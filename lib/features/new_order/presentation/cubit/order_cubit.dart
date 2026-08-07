import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/create_order_request_model.dart';
import '../../data/repositories/order_repository_impl.dart.dart';
import 'order_state.dart';

class CreateOrderCubit extends Cubit<CreateOrderState> {
  final OrderRepositoryImpl repository;

  CreateOrderCubit(this.repository)
      : super(CreateOrderInitial());

  Future<void> createOrder(
      CreateOrderRequestModel request,
      ) async {
    emit(CreateOrderLoading());

    try {
      final order = await repository.createOrder(request);

      emit(CreateOrderSuccess(order));
    } catch (e) {
      emit(CreateOrderError(e.toString()));
    }
  }
}