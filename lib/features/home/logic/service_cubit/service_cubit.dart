import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zero_one_z_task/features/home/data/models/service_model.dart';
import 'package:zero_one_z_task/features/home/data/repo/home_repo/home_repo.dart';
import 'package:zero_one_z_task/features/home/logic/service_cubit/service_state.dart';

class ServiceCubit extends Cubit<ServiceState> {
  final HomeRepo homeRepo;

  int currentPage = 1;
  int itemsPerPage = 10;
  int totalServices = 0;
  bool hasMoreData = true;

  ServiceCubit(this.homeRepo) : super(ServiceInitial());

  Future<void> fetchServices({bool refresh = false, int? limit}) async {
    if (refresh) {
      currentPage = 1;
      hasMoreData = true;
      totalServices = 0;
    }

    if (limit != null) {
      itemsPerPage = limit;
    }

    if (state is ServiceLoading || state is ServiceLoadingMore) return;
    if (!hasMoreData && !refresh) return;

    if (refresh || state is ServiceInitial) {
      emit(ServiceLoading());
    } else if (state is ServiceSuccess) {
      emit(ServiceLoadingMore((state as ServiceSuccess).services));
    }

    var result = await homeRepo.getServices(
      page: currentPage,
      limit: itemsPerPage,
    );

    result.fold((failure) => emit(ServiceFailure(failure.message)), (
      serviceResponse,
    ) {
      totalServices = serviceResponse.total;
      final services = serviceResponse.data;

      if (services.isEmpty) {
        hasMoreData = false;
        if (currentPage == 1) {
          emit(ServiceSuccess(services: [], total: totalServices));
        } else {
          final currentState = state;
          if (currentState is ServiceLoadingMore) {
            emit(
              ServiceSuccess(
                services: currentState.currentServices,
                total: totalServices,
              ),
            );
          }
        }
      } else {
        List<ServiceModel> allServices = [];
        if (state is ServiceLoadingMore) {
          allServices = (state as ServiceLoadingMore).currentServices;
        }
        allServices.addAll(services);

        hasMoreData = allServices.length < totalServices;
        currentPage++;

        emit(ServiceSuccess(services: allServices, total: totalServices));
      }
    });
  }

  void loadMore() {
    if (hasMoreData) {
      fetchServices();
    }
  }

  void refresh({int? limit}) {
    fetchServices(refresh: true, limit: limit);
  }

  void setItemsPerPage(int limit) {
    itemsPerPage = limit;
    refresh(limit: limit);
  }
}
