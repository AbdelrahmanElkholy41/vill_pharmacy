import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_app/features/setting_pharmacy/presentation/widgets/section_card.dart';
import 'package:pharmacy_app/features/setting_pharmacy/presentation/widgets/setting_card.dart';

import '../../../../core/theme/app_colors.dart';
import '../../data/models/pharmacy_modal.dart';

class PharmacyDataCard extends StatelessWidget {
  final PharmacyProfile pharmacy;
  const PharmacyDataCard({required this.pharmacy});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'بيانات الصيدلية',
      child: Column(
        children: [
          InfoRow(label: 'اسم الصيدلية', value: pharmacy.name),
          const InfoDivider(),
          InfoRow(label: 'اسم الصيدلاني', value: pharmacy.pharmacistName),
          const InfoDivider(),
          InfoRow(label: 'العنوان', value: pharmacy.address),
          const InfoDivider(),
          Row(
            children: [
              Expanded(
                child: InfoRow(
                  label: 'فتح',
                  value: pharmacy.openTime,
                  trailingIcon: Icons.access_time_rounded,
                ),
              ),
              Expanded(
                child: InfoRow(
                  label: 'غلق',
                  value: pharmacy.closeTime,
                  trailingIcon: Icons.access_time_rounded,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
class InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData? trailingIcon;

  const InfoRow({
    required this.label,
    required this.value,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: AppColors.textGrey),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
              ),
              if (trailingIcon != null)
                Icon(trailingIcon, size: 15, color: AppColors.textGrey),
            ],
          ),
        ],
      ),
    );
  }
}
