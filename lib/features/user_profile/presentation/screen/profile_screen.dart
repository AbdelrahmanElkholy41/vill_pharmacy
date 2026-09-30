import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../order_status/presentation/widgets/info_order.dart';
import '../../../setting_pharmacy/presentation/widgets/logout_buttom.dart';
import '../../../setting_pharmacy/presentation/widgets/section_card.dart';
import '../widget/setting_card_user_profile.dart';


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
                    SettingsCard(),
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


class _PersonalInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SectionCard(
      title: 'البيانات الشخصية',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoRow(label: 'الاسم', value: 'محمد أحمد'),
          SizedBox(height: 14),
          InfoRow(label: 'رقم الهاتف', value: '01012345678'),
          SizedBox(height: 14),
          InfoRow(
            label: 'العنوان',
            value: 'شارع الجمهورية، قرية بني سويف',
          ),
        ],
      ),
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
    return SectionCard(
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
                color: AppColors.primary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                order.status,
                style: const TextStyle(
                  color: AppColors.primary,
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

