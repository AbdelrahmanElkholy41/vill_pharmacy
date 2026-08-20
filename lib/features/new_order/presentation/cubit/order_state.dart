import '../../data/models/create_order_request_model.dart';

abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderSuccess extends OrderState {
  final OrderModel order;

  OrderSuccess(this.order);
}

class OrdersLoading extends OrderState {}

class OrdersSuccess extends OrderState {
  final List<OrderModel> orders;

  OrdersSuccess(this.orders);
}

class OrderError extends OrderState {
  final String message;

  OrderError(this.message);
}