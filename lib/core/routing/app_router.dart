import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_app/core/routing/routes.dart';

import '../../features/auth/data/datasource/auth_local_data_source_impl.dart';
import '../../features/auth/data/datasource/auth_remote_data_source_impl.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/entities/user_entity.dart';
import '../../features/auth/domain/usecases/login_use_case.dart';
import '../../features/auth/domain/usecases/register_use_case.dart';
import '../../features/auth/presentation/Cubit/login_cubit.dart';
import '../../features/auth/presentation/Cubit/register_cubit.dart';
import '../../features/auth/presentation/screens/login.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/dashboard/presentation/screens/dashboard.dart';
import '../../features/home/presentation/screens/customer_home.dart';
import '../../features/home/presentation/screens/role_screen.dart';
import '../../features/new_order/presentation/screens/new_order.dart';
import '../../features/order_status/presentation/screens/order_status.dart';
import '../helpers/extensions.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => LoginCubit(
              LoginUseCase(
                AuthRepositoryImpl(
                  AuthRemoteDataSourceImpl(
                    Dio(),
                  ),
                  AuthLocalDataSourceImpl(),
                ),
              ),
            ),
            child: Login(),
          ),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(
            builder: (_) => CustomerHomeScreen(
                  onDashboard: () {},
                  onNewOrder: () {},
                  onTrack: () {}, userRole: settings.arguments as UserRole,
                ));
      case Routes.registrationScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (_) {
                  return RegisterCubit(RegisterUseCase(AuthRepositoryImpl(
                    AuthRemoteDataSourceImpl(
                      Dio(),
                    ),
                    AuthLocalDataSourceImpl(),
                  )));
                },
                child: const RegisterScreen()));

      case Routes.dashboardScreen:
        return MaterialPageRoute(
            builder: (_) => PharmacyDashboardScreen(
                  onBack: () {
                    Navigator.pop(_);
                  },
                ));
        case Routes.RoleGeta:
          return MaterialPageRoute(builder: (BuildContext context) {

            return RoleGate(user: settings.arguments as UserEntity,);
          }

          );

      case Routes.track:
        return MaterialPageRoute(
            builder: (_) => OrderStatusScreen(
                  onBack: () {
                    Navigator.pop(_);
                  },
                ));

      case Routes.newOrder:
        return MaterialPageRoute(
            builder: (_) => NewOrderScreen(
                  onBack: () {
                    Navigator.pop(_);
                  },
                ));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
