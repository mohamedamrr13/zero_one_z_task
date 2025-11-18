import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        if (state is ProductLoading) {
          return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: SizedBox(
              height: 190,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    width: 200,
                    height: 190,
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

        if (state is ProductFailure) {
          return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: SizedBox(
              height: 115,
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
                        context.read<ProductCubit>().refresh();
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

        if (state is ProductSuccess || state is ProductLoadingMore) {
          final products = state is ProductSuccess
              ? state.products
              : (state as ProductLoadingMore).currentProducts;

          if (products.isEmpty) {
            return Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: SizedBox(
                height: 115,
                child: Center(
                  child: Text(
                    'لا توجد منتجات',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                ),
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
                    itemCount:
                        products.length + (state is ProductLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index >= products.length) {
                        return Container(
                          width: 200,
                          height: 95,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xffF7FAFF),
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

                      return ProductItem(
                        product: products[index],
                        onTap: () {},
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
