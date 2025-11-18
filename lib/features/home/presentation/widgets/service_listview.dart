import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(child: CircularProgressIndicator()),
                  );
                },
              ),
            ),
          );
        }

        if (state is ServiceFailure) {
          return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: SizedBox(
              height: 220,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.errorMessage,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ServiceCubit>().refresh();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      ),
                      child: const Text(
                        'إعادة المحاولة',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        if (state is ServiceSuccess || state is ServiceLoadingMore) {
          final services = state is ServiceSuccess
              ? state.services
              : (state as ServiceLoadingMore).currentServices;

          if (services.isEmpty) {
            return Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: SizedBox(
                height: 220,
                child: Center(
                  child: Text(
                    'لا توجد خدمات',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                ),
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Services count indicator
              const SizedBox(height: 8),
              // Services list
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: SizedBox(
                  height: 220,
                  child: ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        services.length + (state is ServiceLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index >= services.length) {
                        return Container(
                          width: 170,
                          height: 200,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xffFFF3F7),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.black.withOpacity(0.1),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: CircularProgressIndicator(),
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
