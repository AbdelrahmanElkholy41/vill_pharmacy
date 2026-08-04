import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_app/core/helpers/extensions.dart';

import '../../../../core/routing/routes.dart';
import '../../../auth/presentation/Cubit/auth_cubit.dart';
import '../../data/models/pharmacy_modal.dart';
import '../widgets/stat_card.dart';

/// -----------------------------------------------------------------------
/// App colors used across this screen.
/// In the real project these likely already live in `core/constants/app_colors.dart`
/// — keep this class there and delete it from this file if so.
/// -----------------------------------------------------------------------
class AppColors {
  static const primaryGreen = Color(0xFF1E8E4F);
  static const lightGreenBg = Color(0xFFE9F7EF);
  static const scaffoldBg = Color(0xFFF4F6F8);
  static const cardBg = Colors.white;
  static const textDark = Color(0xFF1D2129);
  static const textGrey = Color(0xFF8A9099);
  static const gold = Color(0xFFF5A623);
  static const orange = Color(0xFFF39C3E);
  static const red = Color(0xFFE5473A);
  static const borderGrey = Color(0xFFE3E6EA);
}
class PharmacyProfileScreen extends StatefulWidget {
  final PharmacyProfile pharmacy;

  final VoidCallback? onLogout;

  const PharmacyProfileScreen({
    super.key,
    required this.pharmacy,
    this.onLogout,
  });

  @override
  State<PharmacyProfileScreen> createState() => _PharmacyProfileScreenState();
}

class _PharmacyProfileScreenState extends State<PharmacyProfileScreen> {
  // Local UI state for the settings toggles.
  // In production these should come from a Cubit/Bloc + persisted storage.
  bool _newOrderNotifications = false;
  bool _vibrateOnNewOrder = false;
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
                _PharmacyHeader(pharmacy: widget.pharmacy),
                const SizedBox(height: 16),
                _StatusChip(isOpen: widget.pharmacy.isOpen),
                const SizedBox(height: 20),
                _StatsRow(pharmacy: widget.pharmacy),
                const SizedBox(height: 20),
                _PharmacyDataCard(pharmacy: widget.pharmacy),
                const SizedBox(height: 20),
                _SettingsCard(
                  newOrderNotifications: _newOrderNotifications,
                  vibrateOnNewOrder: _vibrateOnNewOrder,
                  darkMode: _darkMode,
                  onNewOrderNotificationsChanged: (v) =>
                      setState(() => _newOrderNotifications = v),
                  onVibrateChanged: (v) =>
                      setState(() => _vibrateOnNewOrder = v),
                  onDarkModeChanged: (v) => setState(() => _darkMode = v),
                ),
                const SizedBox(height: 24),
                LogoutButton(),
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
        'بروفايل الصيدلية',
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
          onPressed: (){
            context.pushNamed(Routes.profileEdit);
          },
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
class _PharmacyHeader extends StatelessWidget {
  final PharmacyProfile pharmacy;
  const _PharmacyHeader({required this.pharmacy});

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
          child: const Icon(
            Icons.local_pharmacy_rounded,
            color: AppColors.primaryGreen,
            size: 34,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          pharmacy.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 2),
        const Text(
          'صيدلي',
          style: TextStyle(fontSize: 13, color: AppColors.textGrey),
        ),
      ],
    );
  }
}

/// -----------------------------------------------------------------------
/// "حالة الصيدلية: مفتوح" pill
/// -----------------------------------------------------------------------
class _StatusChip extends StatelessWidget {
  final bool isOpen;
  const _StatusChip({required this.isOpen});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.borderGrey),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'حالة الصيدلية:',
            style: const TextStyle(fontSize: 13, color: AppColors.textDark),
          ),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.lightGreenBg,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isOpen ? 'مفتوح' : 'مغلق',
                  style: const TextStyle(
                    color: AppColors.primaryGreen,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryGreen,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// -----------------------------------------------------------------------
/// Row of the 3 stat cards
/// -----------------------------------------------------------------------
class _StatsRow extends StatelessWidget {
  final PharmacyProfile pharmacy;
  const _StatsRow({required this.pharmacy});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: StatCard(
            icon: Icons.star_rounded,
            iconColor: AppColors.gold,
            value: pharmacy.rating.toStringAsFixed(1),
            label: 'التقييم',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: StatCard(
            icon: Icons.check_circle_rounded,
            iconColor: AppColors.primaryGreen,
            value: '${pharmacy.deliveredCount}',
            label: 'تم التوصيل',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: StatCard(
            icon: Icons.inventory_2_rounded,
            iconColor: AppColors.orange,
            value: '${pharmacy.todayOrdersCount}',
            label: 'طلبات اليوم',
          ),
        ),
      ],
    );
  }
}


class _PharmacyDataCard extends StatelessWidget {
  final PharmacyProfile pharmacy;
  const _PharmacyDataCard({required this.pharmacy});

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'بيانات الصيدلية',
      child: Column(
        children: [
          _InfoRow(label: 'اسم الصيدلية', value: pharmacy.name),
          const _InfoDivider(),
          _InfoRow(label: 'اسم الصيدلاني', value: pharmacy.pharmacistName),
          const _InfoDivider(),
          _InfoRow(label: 'العنوان', value: pharmacy.address),
          const _InfoDivider(),
          Row(
            children: [
              Expanded(
                child: _InfoRow(
                  label: 'فتح',
                  value: pharmacy.openTime,
                  trailingIcon: Icons.access_time_rounded,
                ),
              ),
              Expanded(
                child: _InfoRow(
                  label: 'غلق',
                  value: pharmacy.closeTime,
                  trailingIcon: Icons.access_time_rounded,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData? trailingIcon;

  const _InfoRow({
    required this.label,
    required this.value,
    this.trailingIcon,
  });

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
          Row(
            children: [
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
              ),
              if (trailingIcon != null)
                Icon(trailingIcon, size: 15, color: AppColors.textGrey),
            ],
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
/// "الإعدادات" settings card
/// -----------------------------------------------------------------------
class _SettingsCard extends StatelessWidget {
  final bool newOrderNotifications;
  final bool vibrateOnNewOrder;
  final bool darkMode;
  final ValueChanged<bool> onNewOrderNotificationsChanged;
  final ValueChanged<bool> onVibrateChanged;
  final ValueChanged<bool> onDarkModeChanged;

  const _SettingsCard({
    required this.newOrderNotifications,
    required this.vibrateOnNewOrder,
    required this.darkMode,
    required this.onNewOrderNotificationsChanged,
    required this.onVibrateChanged,
    required this.onDarkModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'الإعدادات',
      child: Column(
        children: [
          _SettingRow(
            label: 'إشعارات الطلبات الجديدة',
            value: newOrderNotifications,
            onChanged: onNewOrderNotificationsChanged,
          ),
          const _InfoDivider(),
          _SettingRow(
            label: 'الاهتزاز عند طلب جديد',
            value: vibrateOnNewOrder,
            onChanged: onVibrateChanged,
          ),
          const _InfoDivider(),
          _SettingRow(
            label: 'الوضع الليلي',
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
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingRow({
    required this.label,
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
            child: Text(
              label,
              style: const TextStyle(fontSize: 14, color: AppColors.textDark),
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
/// Logout button
/// -----------------------------------------------------------------------
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
          foregroundColor: AppColors.red,
          side: const BorderSide(color: AppColors.red),
          backgroundColor: AppColors.red.withOpacity(0.05),
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
