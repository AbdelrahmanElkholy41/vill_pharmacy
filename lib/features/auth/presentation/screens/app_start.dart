import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routing/app_router.dart';
import '../../../../core/routing/routes.dart';
import '../../../home/presentation/screens/customer_home.dart';
import '../../../home/presentation/screens/role_screen.dart';
import '../../data/datasource/auth_local_data_source_impl.dart';
import '../../data/datasource/auth_remote_data_source_impl.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/usecases/login_use_case.dart';
import '../Cubit/auth_cubit.dart';
import '../Cubit/login_cubit.dart';
import 'login.dart';

class AppStart extends StatelessWidget {
  const AppStart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          return RoleGate(user: state.user,);
        }

        if (state is AuthUnauthenticated) {
          return BlocProvider(
            create: (_) => LoginCubit(
              LoginUseCase(
                AuthRepositoryImpl(
                  AuthRemoteDataSourceImpl(Dio()),
                  AuthLocalDataSourceImpl(),
                ),
              ),
            ),
            child: Login(),
          );
        }

        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
