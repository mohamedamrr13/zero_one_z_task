import 'package:dartz/dartz.dart';
import 'package:zero_one_z_task/core/error_handling/error_handling.dart';
import 'package:zero_one_z_task/features/home/data/models/banner_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<BannerModel>>> getBanners();
}
