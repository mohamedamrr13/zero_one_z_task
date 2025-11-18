import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:zero_one_z_task/core/api/api_service.dart';
import 'package:zero_one_z_task/core/error_handling/error_handling.dart';
import 'package:zero_one_z_task/features/home/data/models/banner_model.dart';
import 'package:zero_one_z_task/features/home/data/models/product_response_model.dart';
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

  @override
  Future<Either<Failure, ProductResponseModel>> getProducts({
    int? page,
    int? limit,
  }) async {
    try {
      debugPrint('Fetching products with page: $page, limit: $limit');

      Map<String, dynamic> body = {'page': page ?? 1};
      if (limit != null) {
        body['limit'] = limit;
      }

      var result = await api.post(
        endPoint: 'get_products',
        body: body,
        token: null,
      );

      return result.fold(
        (failure) {
          debugPrint('Product fetch failed: ${failure.message}');
          return Left(failure);
        },
        (data) {
          try {
            debugPrint('Product response received: $data');
            final productResponse = ProductResponseModel.fromJson(data);

            // Check if response is successful
            if (!productResponse.isSuccess) {
              return Left(
                ServerFailure(
                  message: productResponse.message,
                  code: productResponse.code.toString(),
                ),
              );
            }

            debugPrint(
              'Products parsed: ${productResponse.data.length} items, total: ${productResponse.total}',
            );
            return Right(productResponse);
          } catch (e) {
            debugPrint('Error parsing products: $e');
            return Left(
              ServerFailure(
                message: 'Failed to parse products: ${e.toString()}',
              ),
            );
          }
        },
      );
    } catch (e) {
      debugPrint('Unexpected error in getProducts: $e');
      return Left(ServerFailure(message: 'Unexpected error: ${e.toString()}'));
    }
  }
}
