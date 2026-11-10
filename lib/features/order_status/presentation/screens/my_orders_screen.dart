
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/orders_palette.dart';
import '../cubit/order_history_cubit.dart';
import '../cubit/order_history_stats.dart';
import '../widgets/order_card.dart';
import '../widgets/orders_header.dart';
import '../widgets/orders_tabs.dart';
import '../widgets/pending_orders_banner.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  int _tab = 0;

  Future<void> _refreshOrders() async {
    await context.read<OrderHistoryCubit>().getOrderHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: OrdersPalette.background,
        body: SafeArea(
          child: BlocBuilder<OrderHistoryCubit, OrderHistoryState>(
            builder: (context, state) {
              if (state is OrderHistoryLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is OrderHistoryFailure) {
                return _buildErrorState();
              }

              if (state is OrderHistorySuccess) {
                return _buildOrdersContent(state);
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.error_outline,
            size: 48,
            color: Colors.red,
          ),
          const SizedBox(height: 12),
          const Text('تعذر تحميل الطلبات'),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: _refreshOrders,
            child: const Text('إعادة المحاولة'),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersContent(OrderHistorySuccess state) {
    final all = state.orders;

    final pending = all
        .where((order) => order.isActive)
        .toList();

    final visible = _tab == 0 ? all : pending;

    return RefreshIndicator(
      onRefresh: _refreshOrders,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          OrdersHeader(
            subtitle: 'صيدلية القرية',
            title: 'طلباتي',
            onBack: () => Navigator.maybePop(context),
          ),

          const SizedBox(height: 16),

          PendingOrdersBanner(
            pendingCount: pending.length,
          ),

          const SizedBox(height: 16),

          OrdersTabs(
            selectedIndex: _tab,
            allCount: all.length,
            pendingCount: pending.length,
            onChanged: (index) {
              setState(() => _tab = index);
            },
          ),

          const SizedBox(height: 16),

          const Text(
            'سجل الطلبات',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: OrdersPalette.textDark,
            ),
          ),

          const SizedBox(height: 12),

          if (visible.isEmpty)
            _buildEmptyState()
          else
            ...visible.map(
                  (order) => OrderCard(order: order),
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 60,
            color: Colors.grey,
          ),
          SizedBox(height: 12),
          Text(
            'لا توجد طلبات لعرضها',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
