import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import 'app_card.dart';
import 'info_tile.dart';

/// ============================================================
/// بطاقة بيانات الطلب (العميل، رقم الطلب، العنوان)
/// ============================================================
class OrderInfoCard extends StatelessWidget {
  final String customerName;
  final String orderNumber;
  final String address;

  const OrderInfoCard({
    super.key,
    this.customerName = '',
    this.orderNumber = '',
    this.address = '',
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'بيانات الطلب',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 14),
          InfoTile(
            icon: Icons.person_outline,
            label: 'اسم العميل',
            value: customerName,
          ),
          const Divider(height: 24, color: AppColors.border),
          InfoTile(
            icon: Icons.confirmation_number_outlined,
            label: 'رقم الطلب',
            value: orderNumber,
          ),
          const Divider(height: 24, color: AppColors.border),
          InfoTile(
            icon: Icons.location_on_outlined,
            label: 'العنوان',
            value: address,
          ),
        ],
      ),
    );
  }
}
