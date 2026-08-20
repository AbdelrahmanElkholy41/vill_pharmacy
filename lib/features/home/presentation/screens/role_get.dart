import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/data/datasource/auth_local_data_source_impl.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../dashboard_pharmacy/presentation/Cubit/income_cubit.dart';
import '../../../dashboard_pharmacy/presentation/screens/dashboard.dart';
import '../../../dashbord_admin/presentaion/screens/dashborde_for_admin.dart';
import '../../../new_order/data/datasource/remot_data_source_Imp.dart';
import '../../../new_order/data/repositories/order_repository_impl.dart.dart';
import '../../../new_order/presentation/cubit/order_cubit.dart';
import 'customer_home.dart';

class RoleGate extends StatelessWidget {
  final UserEntity user;

  const RoleGate({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    print('-------------------------------------------------------hhhh');
    print(user.role);

    switch (user.role) {
      case UserRole.customer:
        return CustomerHomeScreen(
          onDashboard: () {},
          onNewOrder: () {},
          onTrack: () {},
          userRole: user.role,
        );

      case UserRole.pharmacist:
        return BlocProvider(
          create: (_) => IncomeCubit(
            repository: OrderRepositoryImpl(
              OrderRemoteDataSourceImpl(
                Dio(),
                AuthLocalDataSourceImpl(),
              ),
            ),
          )..getOrders(),
          child: PharmacyDashboardScreen(
            onBack: () {},
          ),
        );

      case UserRole.super_admin:
        return const DashbordeForAdmin();
    }
  }
}