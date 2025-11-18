import 'package:zero_one_z_task/features/home/data/models/service_model.dart';

abstract class ServiceState {}

class ServiceInitial extends ServiceState {}

class ServiceLoading extends ServiceState {}

class ServiceSuccess extends ServiceState {
  final List<ServiceModel> services;
  final int total;

  ServiceSuccess({required this.services, required this.total});
}

class ServiceFailure extends ServiceState {
  final String errorMessage;

  ServiceFailure(this.errorMessage);
}

class ServiceLoadingMore extends ServiceState {
  final List<ServiceModel> currentServices;

  ServiceLoadingMore(this.currentServices);
}
