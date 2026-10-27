
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_app/features/dashboard_pharmacy/data/repository/repositori_imp.dart';
import 'package:pharmacy_app/features/dashboard_pharmacy/presentation/Cubit/all_order_state.dart';

import '../../../../core/widget/toast_message.dart';

class AllOrderCubit extends Cubit<AllOrderState> {
  final RepositoriImp repositoriImp;


  Timer? _timer;
  bool _isFetching = false;

  AllOrderCubit({
  required this.repositoriImp,
  }) : super(AllOrderInitial());



  void startPolling() {
    if (_timer != null) return;

    _timer = Timer.periodic(
      const Duration(seconds: 5),
          (_) {
        getAllOrders(showLoading: false);
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

  Future<void> getAllOrders({bool showLoading = true}) async {
    if (_isFetching || isClosed) return;

    _isFetching = true;

    if (showLoading) {
      emit(AllOrderLoading()  );
    }

    try {
      final orders = await repositoriImp.getAllOrders();

      print("ORDERS FOUND: $orders");

      if (!isClosed) {
        emit(AllOrderSuccess(orders));
      }
    } catch (e) {
      if (!isClosed) {
        emit(AllOrderError(AppToast.getErrorMessage(e)));      }
    } finally {
      _isFetching = false;
    }
  }

}