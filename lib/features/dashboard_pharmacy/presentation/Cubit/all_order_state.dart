import '../../data/modal/all_order_modal.dart';
abstract class AllOrderState {}

class AllOrderInitial extends AllOrderState {}

class  AllOrderLoading extends AllOrderState {}

class  AllOrderSuccess extends AllOrderState {
  final List<AllOrderModal> orders;

  AllOrderSuccess(this.orders);
}

class  AllOrderError extends AllOrderState {
  final String message;

  AllOrderError(this.message);
}