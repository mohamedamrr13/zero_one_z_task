import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zero_one_z_task/core/shared/custom_empty_state_widget.dart';
import 'package:zero_one_z_task/core/shared/custom_error_widget.dart';
import 'package:zero_one_z_task/core/theming/app_colors.dart';
import 'package:zero_one_z_task/features/home/logic/service_cubit/service_cubit.dart';
import 'package:zero_one_z_task/features/home/logic/service_cubit/service_state.dart';
import 'package:zero_one_z_task/features/home/presentation/widgets/service_item.dart';

class ServiceListView extends StatefulWidget {
  final int? itemsPerPage;

  const ServiceListView({super.key, this.itemsPerPage});

  @override
  State<ServiceListView> createState() => _ServiceListViewState();
}

class _ServiceListViewState extends State<ServiceListView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    if (widget.itemsPerPage != null) {
      context.read<ServiceCubit>().fetchServices(limit: widget.itemsPerPage);
    } else {
      context.read<ServiceCubit>().fetchServices();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      context.read<ServiceCubit>().loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceCubit, ServiceState>(
      builder: (context, state) {
        // Loading State
        if (state is ServiceLoading) {
          return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    width: 170,
                    height: 200,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xffFFF3F7).withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                        strokeWidth: 2,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }

        // Error State
        if (state is ServiceFailure) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomErrorWidget(
              errorMessage: state.errorMessage,
              onRetry: () => context.read<ServiceCubit>().refresh(),
              height: 220,
              icon: Icons.room_service_outlined,
              iconColor: const Color(0xffD946A6),
              buttonColor: const Color(0xffD946A6),
            ),
          );
        }

        // Success & Loading More States
        if (state is ServiceSuccess || state is ServiceLoadingMore) {
          final services = state is ServiceSuccess
              ? state.services
              : (state as ServiceLoadingMore).currentServices;

          // Empty State
          if (services.isEmpty) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: EmptyStateWidget(
                message: 'لا توجد خدمات',
                description: 'لم يتم العثور على أي خدمات متاحة حالياً',
                icon: Icons.room_service_outlined,
                height: 220,
                onAction: () => context.read<ServiceCubit>().refresh(),
                actionText: 'تحديث',
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: SizedBox(
                  height: 220,
                  child: ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount:
                        services.length + (state is ServiceLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      // Loading More Indicator
                      if (index >= services.length) {
                        return Container(
                          width: 170,
                          height: 200,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xffFFF3F7).withOpacity(0.5),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.black.withOpacity(0.05),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                              strokeWidth: 2,
                            ),
                          ),
                        );
                      }

                      return ServiceItem(
                        service: services[index],
                        onTap: () {
                          debugPrint(
                            'Service tapped: ${services[index].title}',
                          );
                          debugPrint('Service ID: ${services[index].id}');
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
