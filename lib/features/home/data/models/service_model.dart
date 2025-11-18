class ServiceModel {
  final int id;
  final int subCategoryId;
  final dynamic price; // Can be int or String
  final dynamic offerPrice;
  final String? deletedAt;
  final String title;
  final String description;
  final List<ServiceImageModel> images;
  final List<dynamic> advices;
  final List<dynamic> rates;

  ServiceModel({
    required this.id,
    required this.subCategoryId,
    required this.price,
    this.offerPrice,
    this.deletedAt,
    required this.title,
    required this.description,
    required this.images,
    required this.advices,
    required this.rates,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'] as int,
      subCategoryId: json['sub_category_id'] as int,
      price: json['price'],
      offerPrice: json['offer_price'],
      deletedAt: json['deleted_at'] as String?,
      title: json['title'] as String,
      description: json['description'] as String,
      images: (json['images'] as List<dynamic>)
          .map((img) => ServiceImageModel.fromJson(img as Map<String, dynamic>))
          .toList(),
      advices: json['advices'] as List<dynamic>,
      rates: json['rates'] as List<dynamic>,
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
      'images': images.map((img) => img.toJson()).toList(),
      'advices': advices,
      'rates': rates,
    };
  }

  // Helper methods
  bool get hasOffer => offerPrice != null && offerPrice.toString() != 'null';

  bool get isDeleted => deletedAt != null;

  bool get hasMultipleImages => images.length > 1;

  String get imageUrl => images.isNotEmpty ? images.first.image : '';

  double get priceAsDouble {
    try {
      return double.parse(price.toString());
    } catch (e) {
      return 0.0;
    }
  }

  double? get offerPriceAsDouble {
    if (offerPrice == null || offerPrice.toString() == 'null') {
      return null;
    }
    try {
      return double.parse(offerPrice.toString());
    } catch (e) {
      return null;
    }
  }

  double get displayPrice => offerPriceAsDouble ?? priceAsDouble;

  int? get discountPercentage {
    if (!hasOffer) return null;
    final originalPrice = priceAsDouble;
    final offerPriceValue = offerPriceAsDouble;
    if (originalPrice == 0 || offerPriceValue == null) return null;
    return ((originalPrice - offerPriceValue) / originalPrice * 100).round();
  }

  String get formattedPrice => '${priceAsDouble.toStringAsFixed(0)} ج.م';

  String? get formattedOfferPrice => offerPriceAsDouble != null
      ? '${offerPriceAsDouble!.toStringAsFixed(0)} ج.م'
      : null;

  String get formattedDisplayPrice => '${displayPrice.toStringAsFixed(0)} ج.م';

  List<String> get allImageUrls => images.map((img) => img.image).toList();

  @override
  String toString() {
    return 'ServiceModel(id: $id, title: $title, price: $price, offerPrice: $offerPrice)';
  }
}

class ServiceImageModel {
  final int id;
  final int serviceId;
  final String image;

  ServiceImageModel({
    required this.id,
    required this.serviceId,
    required this.image,
  });

  factory ServiceImageModel.fromJson(Map<String, dynamic> json) {
    return ServiceImageModel(
      id: json['id'] as int,
      serviceId: json['service_id'] as int,
      image: json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'service_id': serviceId, 'image': image};
  }

  @override
  String toString() {
    return 'ServiceImageModel(id: $id, serviceId: $serviceId, image: $image)';
  }
}
