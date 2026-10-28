import 'package:flutter/material.dart';
import 'package:pharmacy_app/features/dashboard_pharmacy/presentation/widgets/status_card.dart';

import '../../../new_order/data/models/order_modal.dart';
import '../../data/modal/all_order_modal.dart';
import 'dashbordCard.dart';
import 'delivery_empty_state.dart';

class DeliveryList extends StatelessWidget {
  final List<AllOrderModal>? items;
  final String emptyMessage;

  const DeliveryList({
    super.key,
    required this.items,
    required this.emptyMessage,
  });

  @override
  Widget build(BuildContext context) {

    if (items!.isEmpty) {
      return DeliveryEmptyState(message: emptyMessage);
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: items!.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, i) => StatusCard(
        order:  items![i],
      ),
    );
  }
}
