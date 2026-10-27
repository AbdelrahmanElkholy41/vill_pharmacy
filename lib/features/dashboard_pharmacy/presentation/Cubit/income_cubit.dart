
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_app/features/dashboard_pharmacy/data/repository/repositori_imp.dart';
import 'package:pharmacy_app/features/new_order/data/repositories/order_repository_impl.dart.dart';

import '../../../../core/widget/toast_message.dart';
import 'income_state.dart';

class IncomeCubit extends Cubit<IncomeState> {
  final OrderRepositoryImpl repository;

  IncomeCubit({
    required this.repository,
  }) : super(IncomeInitial());

  Timer? _timer;
  bool _isFetching = false;

  Future<void> getOrders({bool showLoading = true}) async {
    if (_isFetching || isClosed) return;

    _isFetching = true;

    if (showLoading) {
      emit(IncomeLoading());
    }

    try {
      final orders = await repository.getOrders();

      if (!isClosed) {
        emit(IncomeSuccess(orders));
      }
    } catch (e) {
      if (!isClosed) {
        emit(IncomeError(AppToast.getErrorMessage(e)));      }
    } finally {
      _isFetching = false;
    }
  }

  Future<void> acceptOrder(
      String orderId,
      double price,
      int deliveryTime,
      ) async {
    try {
      await repository.acceptOrder(orderId, price, deliveryTime);
      await getOrders(showLoading: false);
    } catch (e) {
      if (!isClosed) {
        emit(IncomeError(AppToast.getErrorMessage(e)));      }
    }
  }

  Future<void> rejectOrder(String orderId, String reason) async {
    try {
      await repository.rejectOrder(orderId, reason);
      await getOrders(showLoading: false);
    } catch (e) {
      if (!isClosed) {
        emit(IncomeError(AppToast.getErrorMessage(e)));      }
    }
  }

  void startPolling() {
    if (_timer != null) return;

    _timer = Timer.periodic(
      const Duration(seconds: 5),
          (_) {
        getOrders(showLoading: false);
      },
    );
  }

  void stopPolling() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  Future<void> close() {
    stopPolling();
    return super.close();
  }



}