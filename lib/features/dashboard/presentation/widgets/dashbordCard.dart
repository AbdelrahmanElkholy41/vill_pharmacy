import 'package:flutter/material.dart';

import '../../../home/presentation/screens/home.dart';

class DashboardOrderCard extends StatelessWidget {
  final OrderRequest order;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const DashboardOrderCard(
      {
        super.key,
        required this.order
        , required this.onAccept,
        required this.onReject
      }
      );
  @override

  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                const Text('📍', style: TextStyle(fontSize: 13)),
                const SizedBox(width: 4),
                Text(order.address,
                    style: const TextStyle(
                        fontSize: 13, color: Color(0xFF6B7280))),
              ]),
              Text('طلب رقم: #${order.id}',
                  style: const TextStyle(
                      fontSize: 13, color: Color(0xFF6B7280))),
            ],
          ),
          const SizedBox(height: 8),
          Text(order.medicineName,
              style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF111827))),
          if (order.hasPrescription) ...[
            const SizedBox(height: 6),
            Row(mainAxisSize: MainAxisSize.min, children: const [
              Text('🖼️', style: TextStyle(fontSize: 12)),
              SizedBox(width: 4),
              Text('يوجد صورة روشتة',
                  style: TextStyle(fontSize: 12, color: Color(0xFF22C55E))),
            ]),
          ],
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: onAccept,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF22C55E),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 0,
                  ),
                  child: const Text('✓ قبول',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: onReject,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEF4444),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 0,
                  ),
                  child: const Text('✕ رفض',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}