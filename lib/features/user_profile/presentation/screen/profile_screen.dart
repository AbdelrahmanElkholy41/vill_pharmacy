import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../order_status/data/modal/order_history_customer.dart';
import '../../../order_status/presentation/cubit/order_history_cubit.dart';
import '../../../order_status/presentation/cubit/order_history_stats.dart';
import '../../../order_status/presentation/widgets/info_order.dart';
import '../../../setting_pharmacy/presentation/widgets/logout_buttom.dart';
import '../../../setting_pharmacy/presentation/widgets/section_card.dart';
import '../widget/setting_card_user_profile.dart';

class ProfileScreen extends StatelessWidget {
  final UserEntity user;
  const ProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: CustomScrollView(
          slivers: [
            _buildAppBarAndHeader(context),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    _PersonalInfoCard(
                      user: user,
                    ),
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

  Widget _buildAppBarAndHeader(BuildContext context) {
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back,
                          color: Colors.white, size: 18),
                      label: const Text('رجوع',
                          style: TextStyle(color: Colors.white)),
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
                      child: const Text('تعديل',
                          style: TextStyle(color: Colors.white)),
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
              Text(
                user.name,
                style: const TextStyle(
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
  final UserEntity user;
  const _PersonalInfoCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'البيانات الشخصية',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoRow(label: 'الاسم', value: user.name),
          const SizedBox(height: 14),
          InfoRow(label: 'رقم الهاتف', value: user.phone),
          const SizedBox(height: 14),
          InfoRow(
            label: 'العنوان',
            value: user.address ?? " لا يوجد عنوان",
          ),
        ],
      ),
    );
  }
}

class _PreviousOrdersCard extends StatelessWidget {
  const _PreviousOrdersCard();

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'طلباتي السابقة',
      child: BlocBuilder<OrderHistoryCubit, OrderHistoryState>(
        builder: (context, state) {
          if (state is OrderHistoryLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is OrderHistoryFailure) {
            return Column(
              children: [
                const Text('تعذر تحميل الطلبات'),
                TextButton(
                  onPressed: () {
                    context.read<OrderHistoryCubit>().getOrderHistory();
                  },
                  child: const Text('إعادة المحاولة'),
                ),
              ],
            );
          }

          if (state is OrderHistorySuccess) {
            final deliveredOrders = state.orders
                .where((order) => order.status.name == 'delivered')
                .toList()
              ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

            final orders = deliveredOrders.take(3).toList();

            if (orders.isEmpty) {
              return const Center(
                child: Text('لا توجد طلبات سابقة'),
              );
            }

            return Column(
              children: [
                for (int i = 0; i < orders.length; i++) ...[
                  OrderTile(order: orders[i]),
                  if (i != orders.length - 1) const Divider(height: 24),
                ],
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class OrderTile extends StatelessWidget {
  final OrderHistoryModel order;

  const OrderTile({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final date = order.createdAt;

    final formattedDate = '${date.day}/${date.month}/${date.year}';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // رقم الطلب والحالة
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'طلب #${order.orderNumber}',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 13,
                      color: AppColors.primary,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'تم الاستلام',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // تفاصيل الطلب
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.medication_outlined,
                  color: AppColors.primary,
                  size: 22,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  order.details,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),
          Divider(
            height: 1,
            color: Colors.grey.withOpacity(0.15),
          ),
          const SizedBox(height: 12),

          // التاريخ والسعر
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today_outlined,
                    size: 14,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    formattedDate,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.payments_outlined,
                    size: 16,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '${order.price} جنيه',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
