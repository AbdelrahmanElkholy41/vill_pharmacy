import 'package:flutter/material.dart';

import '../widgets/info_order.dart';
import '../widgets/mainImage.dart';
import '../widgets/pgarmacy_responsible.dart';

class OrderStatusScreen extends StatelessWidget {
  final VoidCallback onBack;
  const OrderStatusScreen({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: onBack,
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.arrow_forward,
                          size: 16, color: Color(0xFF22C55E)),
                      SizedBox(width: 4),
                      Text('رجوع',
                          style: TextStyle(
                              color: Color(0xFF22C55E),
                              fontWeight: FontWeight.w600,
                              fontSize: 14)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text('حالة الطلب',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF111827))),
                ),
                const SizedBox(height: 20),
                // Status card
                mainIage(),
                const SizedBox(height: 16),
                // Info card
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2))
                    ],
                  ),
                  child: const Column(
                    children: [
                      InfoRow(label: 'رقم الطلب', value: '#12345'),
                      Divider(height: 1, color: Color(0xFFF3F4F6)),
                      InfoRow(label: 'الوقت', value: '٢:٣٠ مساء'),
                      Divider(height: 1, color: Color(0xFFF3F4F6)),
                      InfoRow(label: 'السعر', value: '١٢٠ جنيه'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text('الصيدلية المسؤولة',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF111827))),
                const SizedBox(height: 12),
                // Pharmacy card
                const pharmacyResponsible(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


