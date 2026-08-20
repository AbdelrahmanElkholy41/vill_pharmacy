import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_app/core/routing/routes.dart';
import 'package:pharmacy_app/features/user_profile/profile_screen.dart';
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
import '../../features/dashboard_pharmacy/presentation/Cubit/income_cubit.dart';
import '../../features/dashboard_pharmacy/presentation/screens/dashboard.dart';
import '../../features/home/presentation/screens/customer_home.dart';
import '../../features/home/presentation/screens/role_get.dart';
import '../../features/new_order/data/datasource/remot_data_source_Imp.dart';
import '../../features/new_order/data/repositories/order_repository_impl.dart.dart';
import '../../features/new_order/presentation/cubit/order_cubit.dart';
import '../../features/new_order/presentation/screens/new_order.dart';
import '../../features/order_status/presentation/screens/order_status.dart';
import '../../features/setting_pharmacy/data/models/pharmacy_modal.dart';
import '../../features/setting_pharmacy/presentation/screens/pharmacy_edit_screen.dart';
import '../../features/setting_pharmacy/presentation/screens/pharmacy_profile_screen.dart';

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
                  onTrack: () {},
                  userRole: settings.arguments as UserRole,
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
          builder: (context) => BlocProvider<IncomeCubit>(
            create: (_) {
              final cubit = IncomeCubit(
                repository: OrderRepositoryImpl(
                  OrderRemoteDataSourceImpl(
                    Dio(),
                    AuthLocalDataSourceImpl(),
                  ),
                ),
              );

              cubit.getOrders();

              return cubit;
            },
            child: PharmacyDashboardScreen(
              onBack: () {
                Navigator.pop(context);
              },
            ),
          ),
        );
      case Routes.RoleGeta:
        return MaterialPageRoute(builder: (BuildContext context) {
          return RoleGate(
            user: settings.arguments as UserEntity,
          );
        });
      case Routes.pharmacyProfile:
        return MaterialPageRoute(builder: (BuildContext context) {
          return const PharmacyProfileScreen(
              pharmacy: PharmacyProfile(
                  name: '',
                  pharmacistName: '',
                  address: '',
                  openTime: '',
                  closeTime: '',
                  isOpen: false,
                  rating: 4,
                  deliveredCount: 5,
                  todayOrdersCount: 5));
        });
      case Routes.profileEdit:
        return MaterialPageRoute(builder: (BuildContext context) {
          return const PharmacyEditScreen(
            initialName: '',
            initialPharmacistName: '',
            initialAddress: '',
            initialOpenTime: TimeOfDay(hour: 1, minute: 15),
            initialCloseTime: TimeOfDay(hour: 1, minute: 15),
            initialIsOpen: true,
          );
        });

      case Routes.track:
        return MaterialPageRoute(
            builder: (_) => OrderStatusScreen(
                  onBack: () {
                    Navigator.pop(_);
                  },
                ));

      case Routes.newOrder:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => OrderCubit(
              OrderRepositoryImpl(
                OrderRemoteDataSourceImpl(
                  Dio(),
                  AuthLocalDataSourceImpl(),
                ),
              ),
            ),
            child: NewOrderScreen(
              onBack: () {
                Navigator.pop(_);
              },
            ),
          ),
        );
        case Routes.UserProfile:
          return MaterialPageRoute(builder: (BuildContext context) {
           return const ProfileScreen();
    });
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
