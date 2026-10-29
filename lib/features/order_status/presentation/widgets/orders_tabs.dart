import 'package:flutter/material.dart';
import 'orders_palette.dart';

class OrdersTabs extends StatelessWidget {
  final int selectedIndex; // 0 = all, 1 = not delivered
  final int allCount;
  final int pendingCount;
  final ValueChanged<int> onChanged;

  const OrdersTabs({
    super.key,
    required this.selectedIndex,
    required this.allCount,
    required this.pendingCount,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFE6EBE8),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          _Tab(
              label: 'كل الطلبات ($allCount)',
              selected: selectedIndex == 0,
              onTap: () => onChanged(0)),
          _Tab(
              label: 'لسه موصلتش ($pendingCount)',
              selected: selectedIndex == 1,
              onTap: () => onChanged(1)),
        ],
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _Tab({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Text(label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                color: selected
                    ? OrdersPalette.textDark
                    : OrdersPalette.textMuted,
              )),
        ),
      ),
    );
  }
}
