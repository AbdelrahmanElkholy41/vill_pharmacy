import 'package:flutter/material.dart';

import '../widgets/info_order.dart';

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
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
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
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      vertical: 28, horizontal: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F4FF),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      const Text('💊',
                          style: TextStyle(fontSize: 52)),
                      const SizedBox(height: 14),
                      const Text('يتم تجهيز الطلب',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF3B82F6))),
                      const SizedBox(height: 6),
                      const Text('الصيدلية تحضر طلبك الآن',
                          style: TextStyle(
                              fontSize: 13, color: Color(0xFF6B7280))),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          4,
                              (i) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: i == 1 ? 24 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: i <= 1
                                  ? const Color(0xFF3B82F6)
                                  : const Color(0xFFD1D5DB),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0FDF4),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFBBF7D0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('🧑‍⚕️',
                              style: TextStyle(fontSize: 28)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text('صيدلية النور',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF111827))),
                              const SizedBox(height: 4),
                              Row(children: const [
                                Text('⭐',
                                    style: TextStyle(fontSize: 12)),
                                SizedBox(width: 4),
                                Text('4.5',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF6B7280))),
                                SizedBox(width: 6),
                                Text('•',
                                    style: TextStyle(
                                        color: Color(0xFF9CA3AF))),
                                SizedBox(width: 6),
                                Text('١٢٠+ طلب',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF6B7280))),
                              ]),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Divider(color: Color(0xFFDCFCE7)),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text('شارع الجمهورية - وسط البلد',
                              style: TextStyle(
                                  fontSize: 13, color: Color(0xFF374151))),
                          SizedBox(width: 6),
                          Text('📍', style: TextStyle(fontSize: 13)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text('010 1234 5678',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF22C55E),
                                  fontWeight: FontWeight.w600)),
                          SizedBox(width: 6),
                          Text('📞', style: TextStyle(fontSize: 13)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text('وقت التوصيل المتوقع: ٢٠ دقيقة',
                              style: TextStyle(
                                  fontSize: 13, color: Color(0xFF374151))),
                          SizedBox(width: 6),
                          Text('🕐', style: TextStyle(fontSize: 13)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
