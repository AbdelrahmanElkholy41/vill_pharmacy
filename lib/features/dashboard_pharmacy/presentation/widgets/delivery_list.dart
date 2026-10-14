import 'package:flutter/material.dart';

import '../../../new_order/data/models/create_order_request_model.dart';
import 'dashbordCard.dart';
import 'delivery_empty_state.dart';

class DeliveryList extends StatelessWidget {
  final List<IncomingOrderModel>? items;
  final String emptyMessage;

  const DeliveryList({
    super.key,
    required this.items,
    required this.emptyMessage,
  });

  @override
  Widget build(BuildContext context) {
    final orders = items ?? <IncomingOrderModel>[];

    if (orders.isEmpty) {
      return DeliveryEmptyState(message: emptyMessage);
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, i) => DashboardOrderCard(
        order: orders[i],
        onAccept: () {},
        onReject: () {},
      ),
    );
  }
}
