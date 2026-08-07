import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/theme/app_colors.dart';

/// -----------------------------------------------------------------------
/// Reuse the same AppColors used in the pharmacist profile/edit screens.
/// If it's already defined in `core/constants/app_colors.dart`, delete this
/// block and import that file instead.
/// -----------------------------------------------------------------------


/// -----------------------------------------------------------------------
/// Models
/// -----------------------------------------------------------------------
class CustomerProfile {
  final String name;
  final String phone;
  final String address;

  const CustomerProfile({
    required this.name,
    required this.phone,
    required this.address,
  });
}

enum OrderStatus { delivered, pending, cancelled }

class PastOrder {
  final String orderNumber;
  final String itemsSummary;
  final String pharmacyName;
  final String date;
  final OrderStatus status;

  const PastOrder({
    required this.orderNumber,
    required this.itemsSummary,
    required this.pharmacyName,
    required this.date,
    required this.status,
  });
}

/// -----------------------------------------------------------------------
/// Screen
/// -----------------------------------------------------------------------
class CustomerProfileScreen extends StatefulWidget {
  final CustomerProfile customer;
  final List<PastOrder> orders;
  final VoidCallback? onEdit;

  const CustomerProfileScreen({
    super.key,
    required this.customer,
    required this.orders,
    this.onEdit,
  });

  @override
  State<CustomerProfileScreen> createState() => _CustomerProfileScreenState();
}

class _CustomerProfileScreenState extends State<CustomerProfileScreen> {
  bool _notificationsEnabled = false;
  bool _locationSharingEnabled = false;
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBg,
        appBar: _buildAppBar(context),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              children: [
                _CustomerHeader(customer: widget.customer),
                const SizedBox(height: 20),
                _PersonalDataCard(customer: widget.customer),
                const SizedBox(height: 16),
                _PastOrdersCard(orders: widget.orders),
                const SizedBox(height: 16),
                _SettingsCard(
                  notificationsEnabled: _notificationsEnabled,
                  locationSharingEnabled: _locationSharingEnabled,
                  darkMode: _darkMode,
                  onNotificationsChanged: (v) =>
                      setState(() => _notificationsEnabled = v),
                  onLocationSharingChanged: (v) =>
                      setState(() => _locationSharingEnabled = v),
                  onDarkModeChanged: (v) => setState(() => _darkMode = v),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryGreen,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        'بروفايلي',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      leading: TextButton.icon(
        onPressed: () => Navigator.of(context).maybePop(),
        icon: const Icon(Icons.arrow_back, color: Colors.white, size: 18),
        label: const Text('رجوع', style: TextStyle(color: Colors.white)),
      ),
      actions: [
        TextButton(
          onPressed: widget.onEdit,
          child: const Text(
            'تعديل',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
      ],
    );
  }
}

/// -----------------------------------------------------------------------
/// Avatar + name + role
/// -----------------------------------------------------------------------
class _CustomerHeader extends StatelessWidget {
  final CustomerProfile customer;
  const _CustomerHeader({required this.customer});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: const BoxDecoration(
            color: AppColors.lightGreenBg,
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Text('🧑', style: TextStyle(fontSize: 32)),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          customer.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 2),
        const Text(
          'عميل',
          style: TextStyle(fontSize: 13, color: AppColors.primaryGreen),
        ),
      ],
    );
  }
}

/// -----------------------------------------------------------------------
/// "البيانات الشخصية" card
/// -----------------------------------------------------------------------
class _PersonalDataCard extends StatelessWidget {
  final CustomerProfile customer;
  const _PersonalDataCard({required this.customer});

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'البيانات الشخصية',
      child: Column(
        children: [
          _InfoRow(label: 'الاسم', value: customer.name),
          const _InfoDivider(),
          _InfoRow(label: 'رقم الهاتف', value: customer.phone),
          const _InfoDivider(),
          _InfoRow(label: 'العنوان', value: customer.address),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: AppColors.textGrey),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoDivider extends StatelessWidget {
  const _InfoDivider();

  @override
  Widget build(BuildContext context) {
    return const Divider(height: 1, color: AppColors.borderGrey);
  }
}

/// -----------------------------------------------------------------------
/// "طلباتي السابقة" card
/// -----------------------------------------------------------------------
class _PastOrdersCard extends StatelessWidget {
  final List<PastOrder> orders;
  const _PastOrdersCard({required this.orders});

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'طلباتي السابقة',
      child: Column(
        children: [
          for (int i = 0; i < orders.length; i++) ...[
            _PastOrderTile(order: orders[i]),
            if (i != orders.length - 1) const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class _PastOrderTile extends StatelessWidget {
  final PastOrder order;
  const _PastOrderTile({required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.scaffoldBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _StatusChip(status: order.status),
              const Spacer(),
              Text(
                '#${order.orderNumber}',
                style: const TextStyle(fontSize: 12, color: AppColors.textGrey),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            order.itemsSummary,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Text(
                order.date,
                style: const TextStyle(fontSize: 12, color: AppColors.textGrey),
              ),
              const Spacer(),
              const Icon(Icons.storefront_outlined,
                  size: 13, color: AppColors.textGrey),
              const SizedBox(width: 4),
              Text(
                order.pharmacyName,
                style: const TextStyle(fontSize: 12, color: AppColors.textGrey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final OrderStatus status;
  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    late final String label;
    late final Color color;
    switch (status) {
      case OrderStatus.delivered:
        label = 'تم التوصيل';
        color = AppColors.primaryGreen;
        break;
      case OrderStatus.pending:
        label = 'قيد التنفيذ';
        color = const Color(0xFFF39C3E);
        break;
      case OrderStatus.cancelled:
        label = 'ملغي';
        color = const Color(0xFFE5473A);
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}

/// -----------------------------------------------------------------------
/// "الإعدادات" settings card
/// -----------------------------------------------------------------------
class _SettingsCard extends StatelessWidget {
  final bool notificationsEnabled;
  final bool locationSharingEnabled;
  final bool darkMode;
  final ValueChanged<bool> onNotificationsChanged;
  final ValueChanged<bool> onLocationSharingChanged;
  final ValueChanged<bool> onDarkModeChanged;

  const _SettingsCard({
    required this.notificationsEnabled,
    required this.locationSharingEnabled,
    required this.darkMode,
    required this.onNotificationsChanged,
    required this.onLocationSharingChanged,
    required this.onDarkModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'الإعدادات',
      child: Column(
        children: [
          _SettingRow(
            label: 'الإشعارات',
            icon: Icons.notifications_none_rounded,
            value: notificationsEnabled,
            onChanged: onNotificationsChanged,
          ),
          const _InfoDivider(),
          _SettingRow(
            label: 'مشاركة الموقع',
            icon: Icons.location_on_outlined,
            value: locationSharingEnabled,
            onChanged: onLocationSharingChanged,
          ),
          const _InfoDivider(),
          _SettingRow(
            label: 'الوضع الليلي',
            icon: Icons.dark_mode_outlined,
            value: darkMode,
            onChanged: onDarkModeChanged,
          ),
        ],
      ),
    );
  }
}

class _SettingRow extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingRow({
    required this.label,
    required this.icon,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Icon(icon, size: 18, color: AppColors.textGrey),
                const SizedBox(width: 8),
                Text(
                  label,
                  style:
                  const TextStyle(fontSize: 14, color: AppColors.textDark),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primaryGreen,
          ),
        ],
      ),
    );
  }
}

/// -----------------------------------------------------------------------
/// Shared white rounded card with a title header
/// -----------------------------------------------------------------------
class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}

/// -----------------------------------------------------------------------
/// Example usage
/// -----------------------------------------------------------------------
void main() {
  runApp(const _DemoApp());
}

class _DemoApp extends StatelessWidget {
  const _DemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Cairo', useMaterial3: true),
      home: CustomerProfileScreen(
        customer: const CustomerProfile(
          name: 'محمد أحمد',
          phone: '01012345678',
          address: 'شارع الجمهورية، قرية بني سويف',
        ),
        orders: const [
          PastOrder(
            orderNumber: '12301',
            itemsSummary: 'بنادول اكسترا - علبتين',
            pharmacyName: 'صيدلية النور',
            date: '2024-01-14',
            status: OrderStatus.delivered,
          ),
          PastOrder(
            orderNumber: '12298',
            itemsSummary: 'فيتامين د - 5000 وحدة',
            pharmacyName: 'صيدلية الشفاء',
            date: '2024-01-10',
            status: OrderStatus.delivered,
          ),
          PastOrder(
            orderNumber: '12280',
            itemsSummary: 'روشتة دكتور أحمد',
            pharmacyName: 'صيدلية النور',
            date: '2024-01-05',
            status: OrderStatus.delivered,
          ),
        ],
        onEdit: () {},
      ),
    );
  }
}