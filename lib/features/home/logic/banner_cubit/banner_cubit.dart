import 'package:bloc/bloc.dart';
import 'package:zero_one_z_task/features/home/data/repo/home_repo/home_repo.dart';
import 'package:zero_one_z_task/features/home/logic/banner_cubit/banner_state.dart';

class BannerCubit extends Cubit<BannerState> {
  final HomeRepo homeRepo;

  BannerCubit(this.homeRepo) : super(BannerInitial());

  Future<void> fetchBanners() async {
    emit(BannerLoading());

    var result = await homeRepo.getBanners();

    result.fold(
      (failure) => emit(BannerFailure(failure.message)),
      (banners) => emit(BannerSuccess(banners)),
    );
  }
}
