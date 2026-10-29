import 'package:flutter/material.dart';
import 'orders_palette.dart';

class OrderInfoRow extends StatelessWidget {
  final String pharmacyName;
  final String timeLabel;
  const OrderInfoRow(
      {super.key, required this.pharmacyName, required this.timeLabel});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _Item(icon: Icons.storefront_outlined, text: pharmacyName),
        const Spacer(),
        _Item(icon: Icons.access_time, text: timeLabel),
      ],
    );
  }
}

class _Item extends StatelessWidget {
  final IconData icon;
  final String text;
  const _Item({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: OrdersPalette.primary),
        const SizedBox(width: 4),
        Text(text,
            style: const TextStyle(
                fontSize: 11, color: OrdersPalette.textMuted)),
      ],
    );
  }
}
