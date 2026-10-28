import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widget/toast_message.dart';
import '../../data/modal/all_order_modal.dart';
import '../Cubit/all_order_cubit.dart';
import '../Cubit/all_order_state.dart';
import '../widgets/delivery_list.dart';

class DeliveryTrackingScreen extends StatelessWidget {
  const DeliveryTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AllOrderCubit, AllOrderState>(
      listener: (context, state) {
        if (state is AllOrderError) {
          AppToast.show(message: state.message, context);
        }
      },
      builder: (context, state) {
        List<AllOrderModal> allItems = [];

        if (state is AllOrderSuccess) {
          allItems = state.orders;
        }

        final delivered = allItems
            .where((order) => order.status.toLowerCase() == 'delivered')
            .toList();

        final onTheWay = allItems
            .where((order) =>
                order.status.toLowerCase() == 'accepted' ||
                order.status.toLowerCase() == 'preparing')
            .toList()
            .reversed
            .toList();

        return Directionality(
          textDirection: TextDirection.rtl,
          child: DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: AppColors.background,
              appBar: AppBar(
                backgroundColor: AppColors.background,
                elevation: 0,
                centerTitle: true,
                foregroundColor: AppColors.textPrimary,
                title: const Text(
                  'متابعة التوصيل',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_forward, size: 22),
                  onPressed: () => Navigator.of(context).maybePop(),
                ),
                bottom: TabBar(
                  labelColor: AppColors.primary,
                  unselectedLabelColor: AppColors.textSecondary,
                  indicatorColor: AppColors.primary,
                  indicatorWeight: 3,
                  tabs: [
                    Tab(text: 'في الطريق (${onTheWay.length})'),
                    Tab(text: 'تم التوصيل (${delivered.length})'),
                  ],
                ),
              ),
              body: SafeArea(
                child: Builder(
                  builder: (context) {
                    if (state is AllOrderLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (state is AllOrderError) {
                      return const Center(
                        child: Text('حصل خطأ أثناء تحميل الطلبات'),
                      );
                    }

                    return TabBarView(
                      children: [
                        DeliveryList(
                          items: onTheWay,
                          emptyMessage: 'لا توجد منتجات في الطريق حاليًا',
                        ),
                        DeliveryList(
                          items: delivered,
                          emptyMessage: 'لا توجد منتجات تم توصيلها بعد',
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
