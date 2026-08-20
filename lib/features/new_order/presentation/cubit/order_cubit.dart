import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/create_order_request_model.dart';
import '../../data/repositories/order_repository_impl.dart.dart';
import 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepositoryImpl repository;

  OrderCubit(this.repository) : super(OrderInitial());

  Future<void> createOrder(
      CreateOrderRequestModel request,
      ) async {
    emit(OrderLoading());

    try {
      final order = await repository.createOrder(request);

      emit(OrderSuccess(order));
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }

}