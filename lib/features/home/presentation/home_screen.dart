import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zero_one_z_task/core/api/api_service.dart';
import 'package:zero_one_z_task/core/theming/app_colors.dart';
import 'package:zero_one_z_task/features/home/data/repo/home_repo/home_repo_impl.dart';
import 'package:zero_one_z_task/features/home/logic/banner_cubit/banner_cubit.dart';
import 'package:zero_one_z_task/features/home/logic/product_cubit/product_cubit.dart';
import 'package:zero_one_z_task/features/home/logic/service_cubit/service_cubit.dart';
import 'package:zero_one_z_task/features/home/presentation/widgets/home_screen_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BannerCubit(HomeRepoImpl(Api(Dio()))),
        ),
        BlocProvider(
          create: (context) => ProductCubit(HomeRepoImpl(Api(Dio()))),
        ),
        BlocProvider(
          create: (context) => ServiceCubit(HomeRepoImpl(Api(Dio()))),
        ),
      ],
      child: Scaffold(backgroundColor: AppColors.white, body: HomeScreenBody()),
    );
  }
}
