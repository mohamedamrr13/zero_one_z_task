import 'package:zero_one_z_task/features/home/data/models/product_model.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductSuccess extends ProductState {
  final List<ProductModel> products;
  final int total;

  ProductSuccess({required this.products, required this.total});
}

class ProductFailure extends ProductState {
  final String errorMessage;

  ProductFailure(this.errorMessage);
}

class ProductLoadingMore extends ProductState {
  final List<ProductModel> currentProducts;

  ProductLoadingMore(this.currentProducts);
}
