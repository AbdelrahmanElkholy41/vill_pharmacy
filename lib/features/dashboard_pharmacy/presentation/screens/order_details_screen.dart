import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../new_order/data/models/create_order_request_model.dart';
import '../widgets/new_order_badge.dart';
import '../widgets/order_decision_bar.dart';
import '../widgets/order_info_card.dart';
import '../widgets/order_notes_card.dart';
import '../widgets/prescription_image_card.dart';

class OrderDetailsScreen extends StatelessWidget {
  final IncomingOrderModel order;
  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Directionality(

      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: _buildAppBar(context),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                PrescriptionImageCard(imageUrl:order.prescriptionImage),
                const SizedBox(height: 16),
                const NewOrderBadge(),
                const SizedBox(height: 16),
                const OrderInfoCard(),
                const SizedBox(height: 16),
                const OrderNotesCard(notes: ''),
              ],
            ),
          ),
        ),
        bottomNavigationBar: OrderDecisionBar(
          onAccept: () {
            print(order.prescriptionImage);
          },
          onReject: () {
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      centerTitle: true,
      foregroundColor: AppColors.textPrimary,
      title: const Text(
        'تفاصيل الطلب',
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_forward, size: 22),
        onPressed: () => Navigator.of(context).maybePop(),
      ),
      shape: const Border(bottom: BorderSide(color: AppColors.border, width: 1)),
    );
  }
}
