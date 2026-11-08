
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_app/features/order_status/data/repoistory/order_history_repoistory.dart';

import '../../data/datasource/order_history_remote_dataSource.dart';
import 'order_history_stats.dart';

class OrderHistoryCubit extends Cubit<OrderHistoryState> {
final OrderHistoryRepoistory historyRepoistory;
  OrderHistoryCubit(this.historyRepoistory)
      : super(const OrderHistoryInitial());

  Future<void> getOrderHistory() async {
    emit(const OrderHistoryLoading());

    try {
      final orders = await historyRepoistory.getOrderHistory();

      emit(
        OrderHistorySuccess(
          orders: orders,
          stats: const {},
        ),
      );
    } on DioException catch (e) {
      emit(
        OrderHistoryFailure(
          e.response?.data is Map
              ? (e.response?.data['message']?.toString() ??
              'حصل خطأ أثناء تحميل الطلبات')
              : 'تعذر الاتصال بالسيرفر، حاول مرة تانية',
        ),
      );
    } catch (e) {
      emit(
        const OrderHistoryFailure(
          'حصل خطأ أثناء تحميل سجل الطلبات',
        ),
      );
    }
  }
}
