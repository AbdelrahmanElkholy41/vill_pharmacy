
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/network/dio_client.dart';
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

import '../../features/dashboard_pharmacy/data/dataSource/all_order_remote_datasource_imp.dart';
import '../../features/dashboard_pharmacy/data/repository/repositori_imp.dart';
import '../../features/dashboard_pharmacy/presentation/Cubit/all_order_cubit.dart';
import '../../features/dashboard_pharmacy/presentation/Cubit/income_cubit.dart';
import '../../features/dashboard_pharmacy/presentation/screens/dashboard.dart';
import '../../features/dashboard_pharmacy/presentation/screens/delivery_tracking_screen.dart';
import '../../features/dashboard_pharmacy/presentation/screens/order_details_screen.dart';

import '../../features/home/data/dataSource/remot_data_source_imp.dart';
import '../../features/home/data/repositories/pharmacy_nearby_repository.dart';
import '../../features/home/presentation/cubit/pharmacy_near_cubit.dart';
import '../../features/home/presentation/screens/CustomerShell.dart';
import '../../features/home/presentation/screens/customer_home.dart';
import '../../features/home/presentation/screens/role_get.dart';

import '../../features/new_order/data/datasource/remot_data_source_Imp.dart';
import '../../features/new_order/data/models/order_modal.dart';
import '../../features/new_order/data/repositories/order_repository_impl.dart.dart';
import '../../features/new_order/presentation/cubit/order_cubit.dart';
import '../../features/new_order/presentation/screens/new_order.dart';

import '../../features/order_status/data/dataSource/order_history_remote_dataSource_imp.dart';
import '../../features/order_status/data/repoistory/order_history_repoistory.dart';
import '../../features/order_status/presentation/cubit/order_history_cubit.dart';
import '../../features/order_status/presentation/screens/my_orders_screen.dart';
import '../../features/order_status/presentation/screens/order_status.dart';

import '../../features/setting_pharmacy/data/datasource/edit_pharmacy_remote_date_source_Imp.dart';
import '../../features/setting_pharmacy/data/repositories/pharmacy_repositories.dart';
import '../../features/setting_pharmacy/presentation/Cubit/register_pharmacy_cubit.dart';
import '../../features/setting_pharmacy/presentation/screens/pharmacy_edit_screen.dart';
import '../../features/setting_pharmacy/presentation/screens/pharmacy_profile_screen.dart';

import '../../features/user_profile/presentation/screen/profile_screen.dart';

class AppRouter {
  final AuthLocalDataSourceImpl authLocalDataSource =
  AuthLocalDataSourceImpl();

  late final DioClient dioClient = DioClient(authLocalDataSource);

  late final dio = dioClient.dio;

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => LoginCubit(
              LoginUseCase(
                AuthRepositoryImpl(
                  AuthRemoteDataSourceImpl(dio),
                  authLocalDataSource,
                ),
              ),
            ),
            child: Login(),
          ),
        );

      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => PharmacyNearCubit(
              PharmacyNearbyRepositoryImp(
                NearByPharmacyRemotDataSourceImp(
                  dio,
                  authLocalDataSource,
                ),
              ),
            ),
            child: CustomerHomeScreen(
              onDashboard: () {},
              onNewOrder: () {},
              onTrack: () {},
              userRole: settings.arguments as UserRole,
              user: settings.arguments as UserEntity,
            ),
          ),
        );

      case Routes.registrationScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => RegisterCubit(
              RegisterUseCase(
                AuthRepositoryImpl(
                  AuthRemoteDataSourceImpl(dio),
                  authLocalDataSource,
                ),
              ),
            ),
            child: const RegisterScreen(),
          ),
        );

      case Routes.dashboardScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<IncomeCubit>(
            create: (_) {
              final cubit = IncomeCubit(
                repository: OrderRepositoryImpl(
                  OrderRemoteDataSourceImpl(
                    dio,
                    authLocalDataSource,
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
        return MaterialPageRoute(
          builder: (_) => RoleGate(
            user: settings.arguments as UserEntity,
          ),
        );

      case Routes.pharmacyProfile:
        return MaterialPageRoute(
          builder: (_) {
            const storage = FlutterSecureStorage();

            return BlocProvider<PharmacyCubit>(
              create: (_) => PharmacyCubit(
                repository: PharmacyRepositoryImpl(
                  EditPharmacyRemoteDataSourceImpl(
                    dio,
                    authLocalDataSource,
                  ),
                ),
                storage: storage,
              ),
              child: const PharmacyProfileScreen(),
            );
          },
        );

      case Routes.profileEdit:
        return MaterialPageRoute(
          builder: (_) {
            const storage = FlutterSecureStorage();

            return BlocProvider(
              create: (_) => PharmacyCubit(
                repository: PharmacyRepositoryImpl(
                  EditPharmacyRemoteDataSourceImpl(
                    dio,
                    authLocalDataSource,
                  ),
                ),
                storage: storage,
              ),
              child: const PharmacyRegisterScreen(),
            );
          },
        );

      case Routes.track:
        return MaterialPageRoute(
          builder: (context) => OrderStatusScreen(
            onBack: () {
              Navigator.pop(context);
            },
          ),
        );

      case Routes.newOrder:
        final pharmacyCubit = settings.arguments as PharmacyNearCubit;

        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<PharmacyNearCubit>.value(
                value: pharmacyCubit,
              ),
              BlocProvider<OrderCubit>(
                create: (_) => OrderCubit(
                  OrderRepositoryImpl(
                    OrderRemoteDataSourceImpl(
                      dio,
                      authLocalDataSource,
                    ),
                  ),
                ),
              ),
            ],
            child: NewOrderScreen(
              onBack: () {
                Navigator.pop(_);
              },
            ),
          ),
        );

      case Routes.UserProfile:
        final user = settings.arguments as UserEntity;

        return MaterialPageRoute(
          builder: (_) => CustomerShell(
            child: ProfileScreen(user: user),
          ),
        );

      case Routes.orderDetailsScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => IncomeCubit(
              repository: OrderRepositoryImpl(
                OrderRemoteDataSourceImpl(
                  dio,
                  authLocalDataSource,
                ),
              ),
            ),
            child: OrderDetailsScreen(
              order: settings.arguments as IncomingOrderModel,
            ),
          ),
        );

      case Routes.deliveryTrackingScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => AllOrderCubit(
              repositoriImp: RepositoriImp(
                AllOrderRemoteDatasourceImp(
                  dio,
                  authLocalDataSource,
                ),
              ),
            )..getAllOrders(),
            child: const DeliveryTrackingScreen(),
          ),
        );

      case Routes.customerOrders:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => OrderHistoryCubit(
              OrderHistoryRepoistory(
                OrderHistoryRemoteDatasourceImp(
                  dio,
                  authLocalDataSource,
                ),
              ),
            )..getOrderHistory(),
            child: const MyOrdersScreen(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
