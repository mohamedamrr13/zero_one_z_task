class ProductModel {
  final int id;
  final int subCategoryId;
  final String price;
  final String? offerPrice;
  final String? deletedAt;
  final String title;
  final String description;
  final String image;
  final List<ProductImage> images;

  ProductModel({
    required this.id,
    required this.subCategoryId,
    required this.price,
    this.offerPrice,
    this.deletedAt,
    required this.title,
    required this.description,
    required this.image,
    required this.images,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      subCategoryId: json['sub_category_id'] as int,
      price: json['price'] as String,
      offerPrice: json['offer_price'] as String?,
      deletedAt: json['deleted_at'] as String?,
      title: json['title'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      images: (json['images'] as List<dynamic>)
          .map((img) => ProductImage.fromJson(img as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sub_category_id': subCategoryId,
      'price': price,
      'offer_price': offerPrice,
      'deleted_at': deletedAt,
      'title': title,
      'description': description,
      'image': image,
      'images': images.map((img) => img.toJson()).toList(),
    };
  }

  // Helper methods
  bool get hasOffer => offerPrice != null && offerPrice!.isNotEmpty;

  double get priceAsDouble => double.tryParse(price) ?? 0.0;

  double? get offerPriceAsDouble =>
      offerPrice != null ? double.tryParse(offerPrice!) : null;

  double get displayPrice => offerPriceAsDouble ?? priceAsDouble;

  int? get discountPercentage {
    if (!hasOffer) return null;
    final originalPrice = priceAsDouble;
    final offerPriceValue = offerPriceAsDouble!;
    if (originalPrice == 0) return null;
    return ((originalPrice - offerPriceValue) / originalPrice * 100).round();
  }
}

class ProductImage {
  final int id;
  final int productId;
  final String image;

  ProductImage({
    required this.id,
    required this.productId,
    required this.image,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id'] as int,
      productId: json['product_id'] as int,
      image: json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'product_id': productId, 'image': image};
  }
}

class ProductResponse {
  final List<ProductModel> data;
  final String message;
  final int code;
  final int total;

  ProductResponse({
    required this.data,
    required this.message,
    required this.code,
    required this.total,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
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
}
