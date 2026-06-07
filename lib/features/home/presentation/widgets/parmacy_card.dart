import 'dart:ui';

import 'package:flutter/material.dart';

import '../screens/home.dart';

class PharmacyCard extends StatelessWidget {
  final Pharmacy pharmacy;
  PharmacyCard({super.key, required this.pharmacy});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: pharmacy.isOpen
                      ? const Color(0xFF22C55E)
                      : const Color(0xFFEF4444),
                ),
              ),
              const SizedBox(width: 4),
              Text(
                pharmacy.isOpen ? 'مفتوح' : 'مغلق',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: pharmacy.isOpen
                      ? const Color(0xFF22C55E)
                      : const Color(0xFFEF4444),
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(pharmacy.name,
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF111827))),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Text('📍', style: TextStyle(fontSize: 12)),
                  const SizedBox(width: 2),
                  Text(pharmacy.distance,
                      style: const TextStyle(
                          fontSize: 12, color: Color(0xFF6B7280))),
                  const SizedBox(width: 10),
                  const Text('⭐', style: TextStyle(fontSize: 12)),
                  const SizedBox(width: 2),
                  Text(pharmacy.rating.toString(),
                      style: const TextStyle(
                          fontSize: 12, color: Color(0xFF6B7280))),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
