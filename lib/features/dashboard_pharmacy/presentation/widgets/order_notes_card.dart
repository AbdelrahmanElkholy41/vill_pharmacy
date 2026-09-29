import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import 'app_card.dart';

/// ============================================================
/// بطاقة "تفاصيل الطلب" (النص الحر من العميل)
/// ============================================================
class OrderNotesCard extends StatelessWidget {
  final String notes;

  const OrderNotesCard({super.key, required this.notes});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Row(
            children: [
              Icon(Icons.notes_rounded, size: 18, color: AppColors.primary),
              SizedBox(width: 8),
              Text(
                'تفاصيل الطلب',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            notes.isEmpty ? 'لا توجد تفاصيل إضافية لهذا الطلب.' : notes,
            style: const TextStyle(
              fontSize: 13.5,
              height: 1.6,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
