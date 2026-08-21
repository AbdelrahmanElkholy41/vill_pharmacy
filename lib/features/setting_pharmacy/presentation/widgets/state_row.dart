import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_app/features/setting_pharmacy/presentation/widgets/stat_card.dart';

import '../../../../core/theme/app_colors.dart';
import '../../data/models/pharmacy_modal.dart';

class StatsRow extends StatelessWidget {
  final PharmacyProfile pharmacy;
  const StatsRow({required this.pharmacy});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: StatCard(
            icon: Icons.star_rounded,
            iconColor: AppColors.gold,
            value: pharmacy.rating.toStringAsFixed(1),
            label: 'التقييم',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: StatCard(
            icon: Icons.check_circle_rounded,
            iconColor: AppColors.primaryGreen,
            value: '${pharmacy.deliveredCount}',
            label: 'تم التوصيل',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: StatCard(
            icon: Icons.inventory_2_rounded,
            iconColor: AppColors.orange,
            value: '${pharmacy.todayOrdersCount}',
            label: 'طلبات اليوم',
          ),
        ),
      ],
    );
  }
}
