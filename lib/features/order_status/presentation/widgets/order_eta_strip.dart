import 'package:flutter/material.dart';
import 'orders_palette.dart';

class OrderEtaStrip extends StatelessWidget {
  final int minutes;
  const OrderEtaStrip({super.key, required this.minutes});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: const BoxDecoration(
        color: OrdersPalette.primary,
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      child: Row(
        children: [
          const Icon(Icons.local_shipping_outlined,
              size: 16, color: Colors.white),
          const SizedBox(width: 6),
          const Text('طلبك في الطريق إليك',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w700)),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text('خلال $minutes دقيقة',
                style: const TextStyle(color: Colors.white, fontSize: 10)),
          ),
        ],
      ),
    );
  }
}
