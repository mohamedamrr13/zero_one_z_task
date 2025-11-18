import 'package:zero_one_z_task/features/home/data/models/service_model.dart';

class ServiceResponseModel {
  final List<ServiceModel> data;
  final String message;
  final int code;
  final int total;

  ServiceResponseModel({
    required this.data,
    required this.message,
    required this.code,
    required this.total,
  });

  factory ServiceResponseModel.fromJson(Map<String, dynamic> json) {
    return ServiceResponseModel(
      data: (json['data'] as List<dynamic>)
          .map(
            (service) => ServiceModel.fromJson(service as Map<String, dynamic>),
          )
          .toList(),
      message: json['message'] as String,
      code: json['code'] as int,
      total: json['total'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((service) => service.toJson()).toList(),
      'message': message,
      'code': code,
      'total': total,
    };
  }

  // Helper methods
  bool get isSuccess => code == 200;
  bool get hasData => data.isNotEmpty;
  int get servicesCount => data.length;

  @override
  String toString() {
    return 'ServiceResponseModel(code: $code, message: $message, total: $total, services: ${data.length})';
  }
}
