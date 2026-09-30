import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
import '../../../setting_pharmacy/data/models/pharmacy_modal.dart';

import '../../data/dataSource/remot_data_source_imp.dart';
import '../../data/repositories/pharmacy_nearby_repository.dart';
import '../cubit/pharmacy_near_cubit.dart';
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
        return BlocProvider(
          create: (_) => PharmacyNearCubit(PharmacyNearbyRepositoryImp(
              NearByPharmacyRemotDataSourceImp(
                Dio(),
                AuthLocalDataSourceImpl(),
              ))),
          child: CustomerHomeScreen(
            onDashboard: () {},
            onNewOrder: () {},
            onTrack: () {},
            userRole:user.role,
          ),
        );



    // =========================
    // Pharmacist
    // =========================

      case UserRole.pharmacist:

      // عنده pharmacyId
        if (user.pharmacyId != null) {
          return const PharmacistDashboardGate();
        }

        // pharmacyId == null
        // نشوف هل عندنا Pharmacy محفوظة في الـ cache
        return const PharmacistCacheGate();

    // =========================
    // Super Admin
    // =========================

      case UserRole.super_admin:
        return const DashbordeForAdmin();
    }
  }
}


// =====================================================
// Pharmacist Cache Gate
// =====================================================

class PharmacistCacheGate extends StatelessWidget {
  const PharmacistCacheGate({super.key});

  static const storage = FlutterSecureStorage();

  Future<bool> _hasCachedPharmacy() async {
    final cachedPharmacy = await storage.read(
      key: 'pharmacy',
    );

    // مجرد وجود Pharmacy في الـ cache
    // معناه إن الصيدلي عنده Pharmacy
    return cachedPharmacy != null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _hasCachedPharmacy(),
      builder: (context, snapshot) {

        // لسه بنقرأ من الـ storage
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CupertinoActivityIndicator();
        }

        // حصل Error في قراءة الـ storage
        if (snapshot.hasError) {
          return const PharmacyRegisterScreen();
        }

        // Pharmacy موجودة في الـ cache
        if (snapshot.data == true) {
          return const PharmacistDashboardGate();
        }

        // مفيش Pharmacy في الـ cache
        return BlocProvider(
          create: (_) => PharmacyCubit(
            repository: PharmacyRepositoryImpl(
              EditPharmacyRemoteDataSourceImpl(
                Dio(),
                AuthLocalDataSourceImpl(),
              ),
            ),
            storage: storage,
          ),
          child: const PharmacyRegisterScreen(),
        );
      },
    );
  }
}


// =====================================================
// Pharmacist Dashboard
// =====================================================

class PharmacistDashboardGate extends StatelessWidget {
  const PharmacistDashboardGate({super.key});

  @override
  Widget build(BuildContext context) {
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
  }
}