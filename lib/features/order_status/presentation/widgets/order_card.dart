import 'package:flutter/material.dart';
import 'order_actions_row.dart';
import 'order_eta_strip.dart';
import 'order_info_row.dart';
import 'order_model.dart';
import 'order_status_chip.dart';
import 'orders_palette.dart';

class OrderCard extends StatelessWidget {
  final OrderModel1 order;
  final VoidCallback? onDetails;
  final VoidCallback? onCall;
  final VoidCallback? onTrack;
  final VoidCallback? onReorder;

  const OrderCard({
    super.key,
    required this.order,
    this.onDetails,
    this.onCall,
    this.onTrack,
    this.onReorder,
  });

  @override
  Widget build(BuildContext context) {
    final highlighted = order.isActive;
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: OrdersPalette.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: highlighted ? OrdersPalette.primary : OrdersPalette.border,
          width: highlighted ? 1.2 : 1,
        ),
      ),
      child: Column(
        children: [
          if (order.status == OrderStatus.onTheWay && order.etaMinutes != null)
            OrderEtaStrip(minutes: order.etaMinutes!),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('طلب رقم #${order.orderNumber}',
                              style: const TextStyle(
                                  fontSize: 10,
                                  color: OrdersPalette.textMuted)),
                          const SizedBox(height: 4),
                          Text(order.title,
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  color: OrdersPalette.textDark)),
                          if (order.extraItems > 0)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text('+ ${order.extraItems} منتج آخر',
                                  style: const TextStyle(
                                      fontSize: 11,
                                      color: OrdersPalette.orange)),
                            ),
                        ],
                      ),
                    ),
                    OrderStatusChip(status: order.status),
                  ],
                ),
                const Divider(height: 24, color: OrdersPalette.border),
                OrderInfoRow(
                    pharmacyName: order.pharmacyName,
                    timeLabel: order.timeLabel),
                const SizedBox(height: 14),
                OrderActionsRow(
                  status: order.status,
                  onDetails: onDetails ?? () {},
                  onCall: onCall ?? () {},
                  onTrack: onTrack ?? () {},
                  onReorder: onReorder ?? () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
