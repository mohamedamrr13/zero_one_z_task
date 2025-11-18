import 'package:zero_one_z_task/features/home/data/models/product_model.dart';

class ProductResponseModel {
  final List<ProductModel> data;
  final String message;
  final int code;
  final int total;

  ProductResponseModel({
    required this.data,
    required this.message,
    required this.code,
    required this.total,
  });

  factory ProductResponseModel.fromJson(Map<String, dynamic> json) {
    return ProductResponseModel(
      data: (json['data'] as List<dynamic>)
          .map(
            (product) => ProductModel.fromJson(product as Map<String, dynamic>),
          )
          .toList(),
      message: json['message'] as String,
      code: json['code'] as int,
      total: json['total'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((product) => product.toJson()).toList(),
      'message': message,
      'code': code,
      'total': total,
    };
  }

  // Helper methods
  bool get isSuccess => code == 200;
  bool get hasData => data.isNotEmpty;
  int get productsCount => data.length;

  @override
  String toString() {
    return 'ProductResponseModel(code: $code, message: $message, total: $total, products: ${data.length})';
  }
}
