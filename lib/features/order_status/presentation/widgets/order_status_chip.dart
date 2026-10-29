import 'package:flutter/material.dart';
import 'order_model.dart';
import 'orders_palette.dart';

class OrderStatusChip extends StatelessWidget {
  final OrderStatus status;
  const OrderStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final (label, fg, bg) = switch (status) {
      OrderStatus.onTheWay => ('في الطريق', OrdersPalette.primary, OrdersPalette.onTheWayBg),
      OrderStatus.searching => ('جاري البحث', OrdersPalette.searching, OrdersPalette.searchingBg),
      OrderStatus.delivered => ('تم التوصيل', OrdersPalette.primary, OrdersPalette.onTheWayBg),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: fg.withOpacity(0.5)),
      ),
      child: Text(label,
          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: fg)),
    );
  }
}
