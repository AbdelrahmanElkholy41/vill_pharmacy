import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../home/presentation/screens/customer_home.dart';


class ChoosesPharmacy extends StatelessWidget {
  final bool sel;
  final Pharmacy p;


  const ChoosesPharmacy({
    super.key,
    required this.sel,
    required this.p,
  });


  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 145,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: sel
            ? const Color(0xFFDCFCE7)
            : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: sel
              ? const Color(0xFF22C55E)
              : const Color(0xFFE5E7EB),
          width: sel ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.end,
        children: [
          Text(p.name,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: p.isOpen
                      ? const Color(0xFF111827)
                      : const Color(0xFF9CA3AF))),
          const SizedBox(height: 4),
          Row(children: [
            const Text('📍',
                style: TextStyle(fontSize: 10)),
            const SizedBox(width: 2),
            Text(p.distance,
                style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF6B7280))),
            const SizedBox(width: 4),
            const Text('⭐',
                style: TextStyle(fontSize: 10)),
            const SizedBox(width: 2),
            Text(p.rating.toString(),
                style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF6B7280))),
          ]),
          const SizedBox(height: 4),
          Row(children: [
            Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: p.isOpen
                    ? const Color(0xFF22C55E)
                    : const Color(0xFFEF4444),
              ),
            ),
            const SizedBox(width: 4),
            Text(p.isOpen ? 'مفتوح' : 'مغلق',
                style: TextStyle(
                    fontSize: 11,
                    color: p.isOpen
                        ? const Color(0xFF22C55E)
                        : const Color(
                        0xFFEF4444))),
          ]),
        ],
      ),
    );
  }
}
