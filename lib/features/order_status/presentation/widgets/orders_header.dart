import 'package:flutter/material.dart';
import 'orders_palette.dart';

class OrdersHeader extends StatelessWidget {
  final String subtitle;
  final String title;
  final VoidCallback onBack;

  const OrdersHeader({
    super.key,
    required this.subtitle,
    required this.title,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(subtitle,
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: OrdersPalette.primary)),
            Text(title,
                style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: OrdersPalette.textDark)),
          ],
        ),
        const Spacer(),
        InkWell(
          onTap: onBack,
          customBorder: const CircleBorder(),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: OrdersPalette.border),
            ),
            child: const Icon(Icons.arrow_back,
                size: 20, color: OrdersPalette.primary),
          ),
        ),
      ],
    );
  }
}
