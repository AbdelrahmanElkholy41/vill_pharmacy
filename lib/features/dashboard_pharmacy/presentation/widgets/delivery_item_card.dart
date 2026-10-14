import 'package:flutter/material.dart';
import 'package:pharmacy_app/features/new_order/data/models/create_order_request_model.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/delivery_list.dart';

/// شاشة الصيدلي: المنتجات في الطريق + المنتجات اللي وصلت
class DeliveryTrackingScreen extends StatelessWidget {
  final List<IncomingOrderModel>? items;

  const DeliveryTrackingScreen({
    super.key,
    this.items,
  });

  @override
  Widget build(BuildContext context) {
    final allItems = items ?? <IncomingOrderModel>[];

    final onTheWay = allItems.reversed.toList();
    final delivered = <IncomingOrderModel>[];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.background,
            elevation: 0,
            centerTitle: true,
            foregroundColor: AppColors.textPrimary,
            title: const Text(
              'متابعة التوصيل',
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
            bottom: TabBar(
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.textSecondary,
              indicatorColor: AppColors.primary,
              indicatorWeight: 3,
              labelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              tabs: [
                Tab(text: 'في الطريق (${onTheWay.length})'),
                Tab(text: 'تم التوصيل (${delivered.length})'),
              ],
            ),
          ),
          body: SafeArea(
            child: TabBarView(
              children: [
                DeliveryList(
                  items: onTheWay,
                  emptyMessage: 'لا توجد منتجات في الطريق حاليًا',
                ),
                DeliveryList(
                  items: delivered,
                  emptyMessage: 'لا توجد منتجات تم توصيلها بعد',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
