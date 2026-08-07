

import '../../data/models/create_order_request_model.dart';

abstract class CreateOrderState {}

class CreateOrderInitial extends CreateOrderState {}

class CreateOrderLoading extends CreateOrderState {}

class CreateOrderSuccess extends CreateOrderState {
  final OrderModel order;

  CreateOrderSuccess(this.order);
}

class CreateOrderError extends CreateOrderState {
  final String message;

  CreateOrderError(this.message);
}