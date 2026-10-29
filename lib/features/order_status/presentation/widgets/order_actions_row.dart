import 'package:flutter/material.dart';
import 'order_model.dart';
import 'orders_palette.dart';

class OrderActionsRow extends StatelessWidget {
  final OrderStatus status;
  final VoidCallback onDetails;
  final VoidCallback onCall;
  final VoidCallback onTrack;
  final VoidCallback onReorder;

  const OrderActionsRow({
    super.key,
    required this.status,
    required this.onDetails,
    required this.onCall,
    required this.onTrack,
    required this.onReorder,
  });

  @override
  Widget build(BuildContext context) {
    final delivered = status == OrderStatus.delivered;
    return Row(
      children: [
        OutlinedButton.icon(
          onPressed: onDetails,
          icon: const Icon(Icons.keyboard_arrow_down, size: 18),
          label: const Text('التفاصيل'),
          style: OutlinedButton.styleFrom(
            foregroundColor: OrdersPalette.textDark,
            side: const BorderSide(color: OrdersPalette.border),
            minimumSize: const Size(0, 44),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
        if (!delivered) ...[
          const SizedBox(width: 8),
          OutlinedButton(
            onPressed: onCall,
            style: OutlinedButton.styleFrom(
              foregroundColor: OrdersPalette.primary,
              side: const BorderSide(color: OrdersPalette.primary),
              minimumSize: const Size(44, 44),
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: const Icon(Icons.phone_outlined, size: 20),
          ),
        ],
        const SizedBox(width: 8),
        Expanded(
          child: delivered
              ? OutlinedButton.icon(
                  onPressed: onReorder,
                  icon: const Icon(Icons.refresh, size: 18),
                  label: const Text('اطلب مرة أخرى'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: OrdersPalette.primary,
                    side: const BorderSide(color: OrdersPalette.primary),
                    minimumSize: const Size(0, 44),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                )
              : ElevatedButton.icon(
                  onPressed: onTrack,
                  icon: const Icon(Icons.location_on_outlined, size: 18),
                  label: const Text('تابع الطلب'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: OrdersPalette.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    minimumSize: const Size(0, 44),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
        ),
      ],
    );
  }
}
