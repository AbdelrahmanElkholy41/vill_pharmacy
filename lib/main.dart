import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/routing/app_router.dart';
import 'core/routing/routes.dart';
import 'core/theme/app_theme.dart';

import 'features/auth/data/datasource/auth_local_data_source_impl.dart';
import 'features/auth/presentation/Cubit/auth_cubit.dart';
import 'features/auth/presentation/screens/app_start.dart';


void main() {
  runApp(
    BlocProvider(
      create: (_) => AuthCubit(
        AuthLocalDataSourceImpl(),
      )..checkAuth(),

      child: const PharmacyApp(),
    ),
  );
}


class PharmacyApp extends StatelessWidget {
  const PharmacyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,

      builder: (context, child) {

        return MaterialApp(
          title: 'صيدلية القرية',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.theme,

          home: AppStart(),

          onGenerateRoute: AppRouter().generateRoute,
        );

      },
    );
  }
}