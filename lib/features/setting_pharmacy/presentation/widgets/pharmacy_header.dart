import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../data/models/pharmacy_modal.dart';

class PharmacyHeader extends StatelessWidget {
  final PharmacyProfile pharmacy;
  const PharmacyHeader({required this.pharmacy});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: const BoxDecoration(
            color: AppColors.lightGreenBg,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.local_pharmacy_rounded,
            color: AppColors.primaryGreen,
            size: 34,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          pharmacy.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 2),
        const Text(
          'صيدلي',
          style: TextStyle(fontSize: 13, color: AppColors.textGrey),
        ),
      ],
    );
  }
}
