import 'package:flutter/material.dart';

import '../widgets/parmacy_card.dart';

class PharmacyHomeScreen extends StatefulWidget {
  final VoidCallback onDashboard;
  final VoidCallback onNewOrder;
  final VoidCallback onTrack;

  const PharmacyHomeScreen({
    super.key,
    required this.onDashboard,
    required this.onNewOrder,
    required this.onTrack,
  });

  @override
  State<PharmacyHomeScreen> createState() => _PharmacyHomeScreenState();
}

class _PharmacyHomeScreenState extends State<PharmacyHomeScreen> {
  final List<Pharmacy> _pharmacies = [
    Pharmacy(name: 'صيدلية النور', rating: 4.5, distance: '500م', isOpen: true),
    Pharmacy(name: 'صيدلية الشفاء', rating: 4.8, distance: '800م', isOpen: true),
    Pharmacy(name: 'صيدلية الحياة', rating: 4.2, distance: '1.2كم', isOpen: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF0FDF4),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 32),
                      _buildHeader(),
                      const SizedBox(height: 28),
                      _buildOrderButton(),
                      const SizedBox(height: 32),
                      _buildNearbySection(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              _buildBottomNavBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.green.withOpacity(0.15),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Center(child: Text('💊', style: TextStyle(fontSize: 36))),
        ),
        const SizedBox(height: 16),
        const Text(
          'صيدلية القرية',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Color(0xFF14532D),
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'خدمة توصيل الأدوية',
          style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
        ),
      ],
    );
  }

  Widget _buildOrderButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: widget.onNewOrder,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF22C55E),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 4,
          shadowColor: const Color(0xFF22C55E).withOpacity(0.4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('اطلب دواء الآن',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            SizedBox(width: 8),
            Text('💊', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }

  Widget _buildNearbySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          'صيدليات قريبة منك',
          style: TextStyle(
              fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF111827)),
        ),
        const SizedBox(height: 14),
        ...List.generate(
          _pharmacies.length,
              (i) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: PharmacyCard(pharmacy: _pharmacies[i]),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: widget.onDashboard,
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF22C55E),
                side: const BorderSide(color: Color(0xFF22C55E), width: 1.5),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('لوحة الصيدلية',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: widget.onTrack,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF22C55E),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 2,
              ),
              child: const Text('تتبع طلبك',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }
}

class Pharmacy {
  final String name;
  final double rating;
  final String distance;
  final bool isOpen;

  const Pharmacy({
    required this.name,
    required this.rating,
    required this.distance,
    required this.isOpen,
  });
}

class OrderRequest {
  final String id;
  final String address;
  final String medicineName;
  final bool hasPrescription;

  const OrderRequest({
    required this.id,
    required this.address,
    required this.medicineName,
    required this.hasPrescription,
  });
}

