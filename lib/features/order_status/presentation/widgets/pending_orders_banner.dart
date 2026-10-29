import 'package:flutter/material.dart';
import 'orders_palette.dart';

class PendingOrdersBanner extends StatelessWidget {
  final int pendingCount;
  const PendingOrdersBanner({super.key, required this.pendingCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: OrdersPalette.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('عندك $pendingCount طلب لسه موصلش',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                const Text('هنبلغك أول ما حالة أي طلب تتغير',
                    style: TextStyle(color: Colors.white70, fontSize: 11)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.inventory_2_outlined, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
