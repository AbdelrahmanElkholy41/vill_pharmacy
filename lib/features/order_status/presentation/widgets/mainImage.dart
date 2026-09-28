import 'package:flutter/cupertino.dart';

class mainIage extends StatelessWidget {
  const mainIage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
          vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F4FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Text('💊',
              style: TextStyle(fontSize: 52)),
          const SizedBox(height: 14),
          const Text('يتم تجهيز الطلب',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3B82F6))),
          const SizedBox(height: 6),
          const Text('الصيدلية تحضر طلبك الآن',
              style: TextStyle(
                  fontSize: 13, color: Color(0xFF6B7280))),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              4,
                  (i) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: i == 1 ? 24 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: i <= 1
                      ? const Color(0xFF3B82F6)
                      : const Color(0xFFD1D5DB),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
