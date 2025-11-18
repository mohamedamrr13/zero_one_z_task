import 'package:zero_one_z_task/features/home/data/models/banner_model.dart';

abstract class BannerState {}

class BannerInitial extends BannerState {}

class BannerLoading extends BannerState {}

class BannerSuccess extends BannerState {
  final List<BannerModel> banners;

  BannerSuccess(this.banners);
}

class BannerFailure extends BannerState {
  final String errorMessage;

  BannerFailure(this.errorMessage);
}
