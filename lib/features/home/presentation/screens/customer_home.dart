import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_app/core/helpers/extensions.dart';
import 'package:pharmacy_app/features/auth/domain/entities/user_entity.dart';

import '../../../../core/routing/routes.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../cubit/pharmacy_near_cubit.dart';
import '../cubit/pharmacy_near_state.dart';
import '../widgets/parmacy_card.dart';

class CustomerHomeScreen extends StatefulWidget {
  final VoidCallback onDashboard;
  final VoidCallback onNewOrder;
  final VoidCallback onTrack;
  final UserRole userRole;

  const CustomerHomeScreen({
    super.key,
    required this.onDashboard,
    required this.onNewOrder,
    required this.onTrack,
    required this.userRole,
  });

  @override
  State<CustomerHomeScreen> createState() => _PharmacyHomeScreenState();
}

class _PharmacyHomeScreenState extends State<CustomerHomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PharmacyNearCubit>().getNearbyPharmacies(
     20.0444, // latitude
      20.2357, // longitude
    );
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Spacer(),
            IconButton(
              onPressed: () {
                context.pushNamed(Routes.UserProfile);
              },
              icon: const Icon(
                Icons.person_2_outlined,
                color: Colors.green,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFFF0FDF4),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 32),
                      _buildHeader(),
                      const SizedBox(height: 28),
                      _buildOrderButton(),
                      const SizedBox(height: 32),
                      _buildNearbySection(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              _buildBottomNavBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.green.withOpacity(0.15),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child:
              const Center(child: Text('💊', style: TextStyle(fontSize: 36))),
        ),
        const SizedBox(height: 16),
        const Text(
          'صيدلية القرية',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Color(0xFF14532D),
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'خدمة توصيل الأدوية',
          style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
        ),
      ],
    );
  }

  Widget _buildOrderButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          context.pushNamed(Routes.newOrder);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF22C55E),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 4,
          shadowColor: const Color(0xFF22C55E).withOpacity(0.4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('اطلب دواء الآن',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            SizedBox(width: 8),
            Text('💊', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }

  Widget _buildNearbySection() {
    return BlocConsumer<PharmacyNearCubit, PharmacyNearState>(
      listener: (context, state) {
        if (state is PharmacyNearError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is PharmacyNearLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is PharmacyNearSuccess) {
          final pharmacies = state.pharmacies;

          if (pharmacies.isEmpty) {
            return const Center(
              child: Text(
                'لا توجد صيدليات قريبة منك',
                style: TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 15,
                ),
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'صيدليات قريبة منك',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 14),

              ...pharmacies.map(
                    (pharmacy) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: PharmacyCard(
                    pharmacy: pharmacy,
                  ),
                ),
              ),
            ],
          );
        }

        if (state is PharmacyNearError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                context.pushNamed(Routes.track);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF22C55E),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 2,
              ),
              child: const Text('تتبع طلبك',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }
}



class OrderRequest {
  final String id;
  final String address;
  final String medicineName;
  final bool hasPrescription;

  const OrderRequest({
    required this.id,
    required this.address,
    required this.medicineName,
    required this.hasPrescription,
  });
}
