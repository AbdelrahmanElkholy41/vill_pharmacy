import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../home/presentation/screens/home.dart';
import '../widgets/dashbordCard.dart';

class PharmacyDashboardScreen extends StatefulWidget {
  final VoidCallback onBack;
  const PharmacyDashboardScreen({super.key, required this.onBack});

  @override
  State<PharmacyDashboardScreen> createState() =>
      _PharmacyDashboardScreenState();
}

class _PharmacyDashboardScreenState extends State<PharmacyDashboardScreen> {
  List<OrderRequest> _orders = [
    const OrderRequest(
        id: '12345',
        address: 'شارع الجمهورية',
        medicineName: 'بنادول اكسترا - علبتين',
        hasPrescription: true),
    const OrderRequest(
        id: '12346',
        address: 'حي السلام',
        medicineName: 'فيتامين د - 5000 وحدة',
        hasPrescription: false),
    const OrderRequest(
        id: '12347',
        address: 'ميدان المحطة',
        medicineName: 'روشتة دكتور أحمد',
        hasPrescription: true),
  ];

  void _remove(String id, bool accepted) {
    setState(() => _orders = _orders.where((o) => o.id != id).toList());
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(accepted ? 'تم قبول الطلب #$id' : 'تم رفض الطلب #$id'),
      backgroundColor:
      accepted ? const Color(0xFF22C55E) : const Color(0xFFEF4444),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: widget.onBack,
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.arrow_forward,
                              size: 16, color: Color(0xFF22C55E)),
                          SizedBox(width: 4),
                          Text('رجوع',
                              style: TextStyle(
                                  color: Color(0xFF22C55E),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text('لوحة تحكم الصيدلية',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF111827))),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: _orders.isEmpty
                    ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('✅', style: TextStyle(fontSize: 48)),
                      SizedBox(height: 12),
                      Text('لا توجد طلبات جديدة',
                          style: TextStyle(
                              fontSize: 16, color: Color(0xFF6B7280))),
                    ],
                  ),
                )
                    : ListView.builder(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  itemCount: _orders.length,
                  itemBuilder: (_, i) => Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: DashboardOrderCard(
                      order: _orders[i],
                      onAccept: () => _remove(_orders[i].id, true),
                      onReject: () => _remove(_orders[i].id, false),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}