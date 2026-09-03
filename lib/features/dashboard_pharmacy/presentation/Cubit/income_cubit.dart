import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_app/features/new_order/data/repositories/order_repository_impl.dart.dart';

import 'income_state.dart';

class IncomeCubit extends Cubit<IncomeState> {
  final OrderRepositoryImpl repository;

  IncomeCubit({
    required this.repository,
  }) : super(IncomeInitial());

  Timer? _timer;
  bool _isFetching = false;

  Future<void> getOrders({bool showLoading = true}) async {
    if (_isFetching) return;

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
        emit(IncomeError(e.toString()));
      }
    } finally {
      _isFetching = false;
    }
  }

  Future<void> acceptOrder(String orderId) async {
    try {
      await repository.acceptOrder(orderId);

      await getOrders(showLoading: false);
    } catch (e) {
      emit(IncomeError(e.toString()));
    }
  }

  Future<void> rejectOrder(String orderId) async {
    try {
      await repository.rejectOrder(orderId);

      await getOrders(showLoading: false);
    } catch (e) {
      emit(IncomeError(e.toString()));
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