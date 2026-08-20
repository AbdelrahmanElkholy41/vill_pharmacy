import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_app/core/helpers/extensions.dart';
import 'package:pharmacy_app/features/dashboard_pharmacy/presentation/Cubit/income_state.dart';

import '../../../../core/routing/routes.dart';
import '../Cubit/income_cubit.dart';
import '../widgets/dashbordCard.dart';

class PharmacyDashboardScreen extends StatelessWidget {
  final VoidCallback onBack;

  const PharmacyDashboardScreen({
    super.key,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        body: SafeArea(
          child: BlocConsumer<IncomeCubit, IncomeState>(
            listener: (context, state) {
              if (state is IncomeError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: const Color(0xFFEF4444),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is IncomeLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is IncomeError) {
                return _buildError(context);
              }

              if (state is IncomeSuccess) {
                return _buildSuccess(context, state);
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'حدث خطأ أثناء تحميل الطلبات',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF6B7280),
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              context.read<IncomeCubit>().getOrders();
            },
            child: const Text('إعادة المحاولة'),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccess(
      BuildContext context,
      IncomeSuccess state,
      ) {
    final orders = state.orders;

    return Column(
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.fromLTRB(
            16,
            16,
            16,
            0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'لوحة تحكم الصيدلية',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF111827),
                ),
              ),
              IconButton(
                onPressed: () {
                  context.pushNamed(
                    Routes.pharmacyProfile,
                  );
                },
                icon: const Icon(
                  Icons.local_pharmacy,
                  size: 24,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        // Orders
        Expanded(
          child: orders.isEmpty
              ? _buildEmptyOrders()
              : ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];

              return Padding(
                padding: const EdgeInsets.only(
                  bottom: 14,
                ),
                child: DashboardOrderCard(
                  order: order,
                  onAccept: () {
                    print(
                      'Accept order: ${order.id}',
                    );
                  },
                  onReject: () {
                    print(
                      'Reject order: ${order.id}',
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyOrders() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '📭',
            style: TextStyle(fontSize: 48),
          ),
          SizedBox(height: 12),
          Text(
            'لا توجد طلبات جديدة',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }
}