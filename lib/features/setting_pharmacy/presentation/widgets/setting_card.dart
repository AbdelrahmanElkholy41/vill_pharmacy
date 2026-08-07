import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_app/features/setting_pharmacy/presentation/widgets/section_card.dart';
import 'package:pharmacy_app/features/setting_pharmacy/presentation/widgets/setting_row.dart';

import '../../../../core/theme/app_colors.dart';

class SettingsCard extends StatelessWidget {
  final bool newOrderNotifications;
  final bool vibrateOnNewOrder;
  final bool darkMode;
  final ValueChanged<bool> onNewOrderNotificationsChanged;
  final ValueChanged<bool> onVibrateChanged;
  final ValueChanged<bool> onDarkModeChanged;

  const SettingsCard({
    required this.newOrderNotifications,
    required this.vibrateOnNewOrder,
    required this.darkMode,
    required this.onNewOrderNotificationsChanged,
    required this.onVibrateChanged,
    required this.onDarkModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'الإعدادات',
      child: Column(
        children: [
          SettingRow(
            label: 'إشعارات الطلبات الجديدة',
            value: newOrderNotifications,
            onChanged: onNewOrderNotificationsChanged,
          ),
          const InfoDivider(),
          SettingRow(
            label: 'الاهتزاز عند طلب جديد',
            value: vibrateOnNewOrder,
            onChanged: onVibrateChanged,
          ),
          const InfoDivider(),
          SettingRow(
            label: 'الوضع الليلي',
            value: darkMode,
            onChanged: onDarkModeChanged,
          ),
        ],
      ),
    );
  }
}

class InfoDivider extends StatelessWidget {
  const InfoDivider();

  @override
  Widget build(BuildContext context) {
    return const Divider(height: 1, color: AppColors.borderGrey);
  }
}