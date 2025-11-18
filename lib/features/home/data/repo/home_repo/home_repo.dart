import 'package:dartz/dartz.dart';
import 'package:zero_one_z_task/core/error_handling/error_handling.dart';
import 'package:zero_one_z_task/features/home/data/models/banner_model.dart';
import 'package:zero_one_z_task/features/home/data/models/product_response_model.dart';
import 'package:zero_one_z_task/features/home/data/models/service_response_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<BannerModel>>> getBanners();

  Future<Either<Failure, ProductResponseModel>> getProducts({
    int? page,
    int? limit,
  });

  Future<Either<Failure, ServiceResponseModel>> getServices({
    int? page,
    int? limit,
  });
}
