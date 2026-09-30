import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../setting_pharmacy/presentation/widgets/section_card.dart';
import '../../../setting_pharmacy/presentation/widgets/setting_row.dart';

class SettingsCard extends StatefulWidget {
  @override
  State<SettingsCard> createState() => SettingsCardState();
}

class SettingsCardState extends State<SettingsCard> {
  bool notifications = false;
  bool shareLocation = false;
  bool nightMode = false;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'الإعدادات',
      child: Column(
        children: [
          SettingRow(
            icon: Icons.notifications_none,
            label: 'الإشعارات',
            value: notifications,
            onChanged: (v) => setState(() => notifications = v),
          ),
          const Divider(height: 24),
          SettingRow(
            icon: Icons.location_on_outlined,
            label: 'مشاركة الموقع',
            value: shareLocation,
            onChanged: (v) => setState(() => shareLocation = v),
          ),
          const Divider(height: 24),
          SettingRow(
            icon: Icons.nightlight_outlined,
            label: 'الوضع الليلي',
            value: nightMode,
            onChanged: (v) => setState(() => nightMode = v),
          ),
        ],
      ),
    );
  }
}

