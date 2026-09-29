import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// ============================================================
/// شريط القرار الثابت أسفل الصفحة: قبول / رفض
/// ============================================================
class OrderDecisionBar extends StatelessWidget {
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const OrderDecisionBar({
    super.key,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // زر الرفض — ثانوي (Outlined) عشان القبول يفضل هو الأبرز بصريًا
            Expanded(
              child: SizedBox(
                height: 52,
                child: OutlinedButton.icon(
                  onPressed: () => _confirmReject(context),
                  icon: const Icon(Icons.close_rounded, size: 20),
                  label: const Text(
                    'رفض الطلب',
                    style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.bold),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFE0483A),
                    side: const BorderSide(color: Color(0xFFE0483A), width: 1.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // زر القبول — أساسي (Filled)
            Expanded(
              flex: 2,
              child: SizedBox(
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: onAccept,
                  icon: const Icon(Icons.check_circle_outline, size: 20),
                  label: const Text(
                    'قبول الطلب',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// تأكيد بسيط قبل الرفض لتفادي الضغط بالخطأ
  void _confirmReject(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('تأكيد الرفض', style: TextStyle(fontWeight: FontWeight.bold)),
          content: const Text('هل أنت متأكد من رفض هذا الطلب؟'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('تراجع'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                onReject();
              },
              style: TextButton.styleFrom(foregroundColor: const Color(0xFFE0483A)),
              child: const Text('نعم، رفض'),
            ),
          ],
        ),
      ),
    );
  }
}
