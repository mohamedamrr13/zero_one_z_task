import 'package:dartz/dartz.dart';
import 'package:zero_one_z_task/core/api/api_service.dart';
import 'package:zero_one_z_task/core/error_handling/error_handling.dart';
import 'package:zero_one_z_task/features/home/data/models/banner_model.dart';
import 'package:zero_one_z_task/features/home/data/repo/home_repo/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final Api api;

  HomeRepoImpl(this.api);

  @override
  Future<Either<Failure, List<BannerModel>>> getBanners() async {
    try {
      var result = await api.get(endPoint: 'get_banners');

      return result.fold((failure) => Left(failure), (data) {
        try {
          final bannerResponse = BannerResponse.fromJson(data);
          return Right(bannerResponse.data);
        } catch (e) {
          return Left(
            ServerFailure(message: 'Failed to parse banners: ${e.toString()}'),
          );
        }
      });
    } catch (e) {
      return Left(ServerFailure(message: 'Unexpected error: ${e.toString()}'));
    }
  }
}
