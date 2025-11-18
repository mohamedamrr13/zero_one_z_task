import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zero_one_z_task/core/shared/custom_empty_state_widget.dart';
import 'package:zero_one_z_task/core/shared/custom_error_widget.dart';
import 'package:zero_one_z_task/core/theming/app_colors.dart';
import 'package:zero_one_z_task/features/home/logic/product_cubit/product_cubit.dart';
import 'package:zero_one_z_task/features/home/logic/product_cubit/product_state.dart';
import 'package:zero_one_z_task/features/home/presentation/widgets/product_item.dart';

class ProductListView extends StatefulWidget {
  final int? itemsPerPage;

  const ProductListView({super.key, this.itemsPerPage});

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    if (widget.itemsPerPage != null) {
      context.read<ProductCubit>().fetchProducts(limit: widget.itemsPerPage);
    } else {
      context.read<ProductCubit>().fetchProducts();
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
      context.read<ProductCubit>().loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        // Loading State
        if (state is ProductLoading) {
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
                      color: const Color(0xffF7FAFF).withOpacity(0.5),
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
        if (state is ProductFailure) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomErrorWidget(
              errorMessage: state.errorMessage,
              onRetry: () => context.read<ProductCubit>().refresh(),
              height: 220,
              icon: Icons.shopping_bag_outlined,
              iconColor: const Color(0xffD946A6),
              buttonColor: const Color(0xffD946A6),
            ),
          );
        }

        // Success & Loading More States
        if (state is ProductSuccess || state is ProductLoadingMore) {
          final products = state is ProductSuccess
              ? state.products
              : (state as ProductLoadingMore).currentProducts;

          // Empty State
          if (products.isEmpty) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: EmptyStateWidget(
                message: 'لا توجد منتجات',
                description: 'لم يتم العثور على أي منتجات متاحة حالياً',
                icon: Icons.shopping_bag_outlined,
                height: 220,
                onAction: () => context.read<ProductCubit>().refresh(),
                actionText: 'تحديث',
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: SizedBox(
                  height: 220,
                  child: ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount:
                        products.length + (state is ProductLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      // Loading More Indicator
                      if (index >= products.length) {
                        return Container(
                          width: 170,
                          height: 200,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xffF7FAFF).withOpacity(0.5),
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

                      return ProductItem(
                        product: products[index],
                        onTap: () {
                          debugPrint(
                            'Product tapped: ${products[index].title}',
                          );
                          debugPrint('Product ID: ${products[index].id}');
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
