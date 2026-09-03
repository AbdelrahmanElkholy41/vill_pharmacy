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
import '../../../setting_pharmacy/data/datasource/edit_pharmacy_remote_date_source_Imp.dart';
import '../../../setting_pharmacy/data/repositories/pharmacy_repositories.dart';
import '../../../setting_pharmacy/presentation/Cubit/register_pharmacy_cubit.dart';
import '../../../setting_pharmacy/presentation/screens/pharmacy_edit_screen.dart';
import 'customer_home.dart';

class RoleGate extends StatelessWidget {
  final UserEntity user;

  const RoleGate({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    print('USER ROLE: ${user.role}');
    print('PHARMACY ID: ${user.pharmacyId}');

    switch (user.role) {
// =========================
// Customer
// =========================

      case UserRole.customer:
        return CustomerHomeScreen(
          onDashboard: () {},
          onNewOrder: () {},
          onTrack: () {},
          userRole: user.role,
        );

// =========================
// Pharmacist
// =========================

      case UserRole.pharmacist:

// لسه معملش Pharmacy
        if (user.pharmacyId == null) {

          return BlocProvider(
            create: (_) => PharmacyCubit(
              repository: PharmacyRepositoryImpl(
                EditPharmacyRemoteDataSourceImpl(
                  Dio(),
                  AuthLocalDataSourceImpl(),
                ),
              ),
            ),
            child: const PharmacyRegisterScreen(),
          );
        }

// عنده Pharmacy
        return BlocProvider(
          create: (_) => IncomeCubit(
            repository: OrderRepositoryImpl(
              OrderRemoteDataSourceImpl(
                Dio(),
                AuthLocalDataSourceImpl(),
              ),
            ),
          )
            ..getOrders()
            ..startPolling(),
          child: PharmacyDashboardScreen(
            onBack: () {
              Navigator.pop(context);
            },
          ),
        );

// =========================
// Super Admin
// =========================

      case UserRole.super_admin:
        return const DashbordeForAdmin();
    }
  }
}
