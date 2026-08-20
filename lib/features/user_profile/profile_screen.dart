import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/helpers/extensions.dart';
import '../../core/routing/routes.dart';
import '../auth/presentation/Cubit/auth_cubit.dart';

/// ألوان التطبيق - عدّلها لتطابق AppColors الموجودة في مشروعك
class AppColors {
  static const primary = Color(0xFF1FA84C); // أخضر رئيسي
  static const primaryDark = Color(0xFF178A3E);
  static const background = Color(0xFFF4F6F5);
  static const cardBackground = Colors.white;
  static const textPrimary = Color(0xFF1A1A1A);
  static const textSecondary = Color(0xFF8A8A8A);
  static const success = Color(0xFF1FA84C);
  static const danger = Color(0xFFE0483A);
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: CustomScrollView(
          slivers: [
            _buildAppBarAndHeader(),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    _PersonalInfoCard(),
                    const SizedBox(height: 16),
                    _PreviousOrdersCard(),
                    const SizedBox(height: 16),
                    _SettingsCard(),
                    const SizedBox(height: 16),
                    LogoutButton()

                  ],
                ),

              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBarAndHeader() {
    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(bottom: 28),
        decoration: const BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(0)),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  children: [
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_back, color: Colors.white, size: 18),
                      label: const Text('رجوع', style: TextStyle(color: Colors.white)),
                    ),
                    const Spacer(),
                    const Text(
                      'بروفايلي',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: const Text('تعديل', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child: Text('🧑', style: TextStyle(fontSize: 36)),
              ),
              const SizedBox(height: 12),
              const Text(
                'محمد أحمد',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'عميل',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// بطاقة موحّدة تُستخدم لكل الأقسام
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
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _PersonalInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'البيانات الشخصية',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _InfoRow(label: 'الاسم', value: 'محمد أحمد'),
          SizedBox(height: 14),
          _InfoRow(label: 'رقم الهاتف', value: '01012345678'),
          SizedBox(height: 14),
          _InfoRow(
            label: 'العنوان',
            value: 'شارع الجمهورية، قرية بني سويف',
          ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _OrderItem {
  final String id;
  final String title;
  final String pharmacy;
  final String date;
  final String status;
  final bool delivered;

  const _OrderItem({
    required this.id,
    required this.title,
    required this.pharmacy,
    required this.date,
    required this.status,
    required this.delivered,
  });
}

class _PreviousOrdersCard extends StatelessWidget {
  final List<_OrderItem> orders = const [
    _OrderItem(
      id: '#12301',
      title: 'بانادول اكسترا - علنين',
      pharmacy: 'صيدلية النور',
      date: '2024-01-14',
      status: 'تم التوصيل',
      delivered: true,
    ),
    _OrderItem(
      id: '#12298',
      title: 'فيتامين د - 5000 وحدة',
      pharmacy: 'صيدلية الشفاء',
      date: '2024-01-10',
      status: 'تم التوصيل',
      delivered: true,
    ),
    _OrderItem(
      id: '#12280',
      title: 'روشتة دكتور أحمد',
      pharmacy: 'صيدلية النور',
      date: '2024-01-05',
      status: 'تم التوصيل',
      delivered: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'طلباتي السابقة',
      child: Column(
        children: [
          for (int i = 0; i < orders.length; i++) ...[
            _OrderTile(order: orders[i]),
            if (i != orders.length - 1) const Divider(height: 24),
          ],
        ],
      ),
    );
  }
}

class _OrderTile extends StatelessWidget {
  final _OrderItem order;

  const _OrderTile({required this.order});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // شارة الحالة + رقم الطلب
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                order.status,
                style: const TextStyle(
                  color: AppColors.success,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              order.date,
              style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
            ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      order.title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  Text(
                    order.id,
                    style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.storefront_outlined, size: 14, color: AppColors.textSecondary),
                  const SizedBox(width: 4),
                  Text(
                    order.pharmacy,
                    style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SettingsCard extends StatefulWidget {
  @override
  State<_SettingsCard> createState() => _SettingsCardState();
}

class _SettingsCardState extends State<_SettingsCard> {
  bool notifications = false;
  bool shareLocation = false;
  bool nightMode = false;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'الإعدادات',
      child: Column(
        children: [
          _SettingRow(
            icon: Icons.notifications_none,
            label: 'الإشعارات',
            value: notifications,
            onChanged: (v) => setState(() => notifications = v),
          ),
          const Divider(height: 24),
          _SettingRow(
            icon: Icons.location_on_outlined,
            label: 'مشاركة الموقع',
            value: shareLocation,
            onChanged: (v) => setState(() => shareLocation = v),
          ),
          const Divider(height: 24),
          _SettingRow(
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

class _SettingRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          value ? 'مفعّلة' : 'معطّلة',
          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
        const Spacer(),
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryDark,
              ),
            ),
            const SizedBox(width: 8),
            Icon(icon, size: 20, color: AppColors.primary),
          ],
        ),
        const SizedBox(width: 8),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.primary,
        ),
      ],
    );
  }
}
class LogoutButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: OutlinedButton.icon(

        onPressed: () async {
          await context.read<AuthCubit>().logout();
          if (context.mounted) {
            context.pushNamedAndRemoveUntil(
              Routes.login,
              predicate: (route) => false,
            );
          }

        },
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.danger,
          side: BorderSide(color: AppColors.danger),
          backgroundColor: AppColors.danger.withOpacity(0.05),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: const Icon(Icons.logout_rounded, size: 18),
        label: const Text(
          'تسجيل الخروج',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}