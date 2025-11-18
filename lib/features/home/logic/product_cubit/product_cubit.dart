import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zero_one_z_task/features/home/data/models/product_model.dart';
import 'package:zero_one_z_task/features/home/data/repo/home_repo/home_repo.dart';
import 'package:zero_one_z_task/features/home/logic/product_cubit/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final HomeRepo homeRepo;

  int currentPage = 1;
  int itemsPerPage = 10;
  int totalProducts = 0;
  bool hasMoreData = true;

  ProductCubit(this.homeRepo) : super(ProductInitial());

  Future<void> fetchProducts({bool refresh = false, int? limit}) async {
    if (refresh) {
      currentPage = 1;
      hasMoreData = true;
      totalProducts = 0;
    }

    if (limit != null) {
      itemsPerPage = limit;
    }

    if (state is ProductLoading || state is ProductLoadingMore) return;
    if (!hasMoreData && !refresh) return;

    if (refresh || state is ProductInitial) {
      emit(ProductLoading());
    } else if (state is ProductSuccess) {
      emit(ProductLoadingMore((state as ProductSuccess).products));
    }

    var result = await homeRepo.getProducts(
      page: currentPage,
      limit: itemsPerPage,
    );

    result.fold((failure) => emit(ProductFailure(failure.message)), (
      productResponse,
    ) {
      totalProducts = productResponse.total;
      final products = productResponse.data;

      if (products.isEmpty) {
        hasMoreData = false;
        if (currentPage == 1) {
          emit(ProductSuccess(products: [], total: totalProducts));
        } else {
          final currentState = state;
          if (currentState is ProductLoadingMore) {
            emit(
              ProductSuccess(
                products: currentState.currentProducts,
                total: totalProducts,
              ),
            );
          }
        }
      } else {
        List<ProductModel> allProducts = [];
        if (state is ProductLoadingMore) {
          allProducts = (state as ProductLoadingMore).currentProducts;
        }
        allProducts.addAll(products);

        hasMoreData = allProducts.length < totalProducts;

        currentPage++;

        emit(ProductSuccess(products: allProducts, total: totalProducts));
      }
    });
  }

  void loadMore() {
    if (hasMoreData) {
      fetchProducts();
    }
  }

  void refresh({int? limit}) {
    fetchProducts(refresh: true, limit: limit);
  }

  void setItemsPerPage(int limit) {
    itemsPerPage = limit;
    refresh(limit: limit);
  }
}
