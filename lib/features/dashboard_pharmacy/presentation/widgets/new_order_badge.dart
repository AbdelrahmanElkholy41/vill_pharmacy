import 'package:flutter/material.dart';

class NewOrderBadge extends StatelessWidget {
  const NewOrderBadge({super.key});

  @override
  Widget build(BuildContext context) {
    const color = Color(0xFFE0A21F); // أصفر هادئ يدل على انتظار القرار
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.10),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: const Row(
        children: [
          Icon(Icons.fiber_new_rounded, color: color, size: 22),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'طلب جديد — بانتظار قرارك',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
