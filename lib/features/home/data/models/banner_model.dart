class BannerModel {
  final int id;
  final String image;
  final String? link;

  BannerModel({required this.id, required this.image, this.link});

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'] as int,
      image: json['image'] as String,
      link: json['link'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'image': image, 'link': link};
  }
}

class BannerResponse {
  final List<BannerModel> data;
  final String message;
  final int code;

  BannerResponse({
    required this.data,
    required this.message,
    required this.code,
  });

  factory BannerResponse.fromJson(Map<String, dynamic> json) {
    return BannerResponse(
      data: (json['data'] as List<dynamic>)
          .map((banner) => BannerModel.fromJson(banner as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String,
      code: json['code'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((banner) => banner.toJson()).toList(),
      'message': message,
      'code': code,
    };
  }
}
