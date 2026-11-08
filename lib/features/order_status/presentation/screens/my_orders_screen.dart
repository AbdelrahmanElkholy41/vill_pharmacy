
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widget/toast_message.dart';
import '../cubit/order_history_cubit.dart';
import '../cubit/order_history_stats.dart';
import '../widgets/order_card.dart';
import '../widgets/orders_header.dart';
import '../widgets/orders_palette.dart';
import '../widgets/orders_tabs.dart';
import '../widgets/pending_orders_banner.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderHistoryCubit, OrderHistoryState>(
      listener: (context, state) {
        if (state is OrderHistoryFailure) {
          AppToast.show(
            message: state.message,
            context,
          );
        }
      },
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: OrdersPalette.background,
            body: SafeArea(
              child: Builder(
                builder: (context) {
                  if (state is OrderHistoryLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is OrderHistoryFailure) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('تعذر تحميل الطلبات'),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () {
                              context
                                  .read<OrderHistoryCubit>()
                                  .getOrderHistory();
                            },
                            child: const Text('إعادة المحاولة'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is OrderHistorySuccess) {
                    final all = state.orders;

                    final pending =
                    all.where((order) => order.isActive).toList();

                    final visible = _tab == 0 ? all : pending;

                    return ListView(
                      padding: const EdgeInsets.fromLTRB(
                        16, 12, 16, 24,
                      ),
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
                          onChanged: (i) {
                            setState(() => _tab = i);
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
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.all(24),
                              child: Text('لا توجد طلبات لعرضها'),
                            ),
                          )
                        else
                          ...visible.map(
                                (order) => OrderCard(order: order),
                          ),
                      ],
                    );
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
