import 'package:flutter/material.dart';
import '../widgets/order_card.dart';
import '../widgets/order_model.dart';
import '../widgets/orders_header.dart';
import '../widgets/orders_palette.dart';
import '../widgets/orders_tabs.dart';
import '../widgets/pending_orders_banner.dart';

class MyOrdersScreen extends StatefulWidget {
  final List<OrderModel1> orders;
  const MyOrdersScreen({super.key, required this.orders});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    final all = widget.orders;
    final pending = all.where((o) => o.isActive).toList();
    final visible = _tab == 0 ? all : pending;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: OrdersPalette.background,
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            children: [
              OrdersHeader(
                subtitle: 'صيدلية القرية',
                title: 'طلباتي',
                onBack: () => Navigator.maybePop(context),
              ),
              const SizedBox(height: 16),
              PendingOrdersBanner(pendingCount: pending.length),
              const SizedBox(height: 16),
              OrdersTabs(
                selectedIndex: _tab,
                allCount: all.length,
                pendingCount: pending.length,
                onChanged: (i) => setState(() => _tab = i),
              ),
              const SizedBox(height: 16),
              const Text('سجل الطلبات',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: OrdersPalette.textDark)),
              const SizedBox(height: 12),
              ...visible.map((o) => OrderCard(order: o)),
            ],
          ),
        ),
      ),
    );
  }
}

// Sample data for quick testing
const sampleOrders = [
  OrderModel1(
    id: '1', orderNumber: '12345', title: 'بنادول إكسترا — علبتان',
    extraItems: 1, pharmacyName: 'صيدلية النور', timeLabel: 'اليوم، ٢:٠٣ م',
    status: OrderStatus.onTheWay, etaMinutes: 15,
  ),
  OrderModel1(
    id: '2', orderNumber: '12346', title: 'روشتة د. أحمد محمود',
    pharmacyName: 'جاري البحث عن صيدلية قريبة', timeLabel: 'اليوم، ١:٤٥ م',
    status: OrderStatus.searching,
  ),
  OrderModel1(
    id: '3', orderNumber: '12301', title: 'كونجستال — علبة',
    extraItems: 1, pharmacyName: 'صيدلية الشفاء', timeLabel: '١٤ يناير، ٥:٢٠ م',
    status: OrderStatus.delivered,
  ),
];
