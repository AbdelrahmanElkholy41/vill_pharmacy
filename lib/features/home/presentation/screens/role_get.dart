import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_app/features/home/presentation/screens/pharmacy_home.dart';

import '../../../auth/domain/entities/user_entity.dart';
import '../../../auth/presentation/Cubit/auth_cubit.dart';
import '../../../dashboard/presentation/screens/dashboard.dart';
import 'customer_home.dart';

class RoleGate extends StatelessWidget {
  final UserEntity user;
  const RoleGate({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    switch (user.role) {
      case UserRole.customer:
        return CustomerHomeScreen(
          onDashboard: () {},
          onNewOrder: () {},
          onTrack: () {},
          userRole: user.role,
        );

      case UserRole.pharmacist:
        return PharmacyDashboardScreen(onBack: () {  },);
    }
  }
}
