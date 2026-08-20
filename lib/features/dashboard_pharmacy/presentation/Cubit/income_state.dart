import '../../../new_order/data/models/create_order_request_model.dart';
abstract class IncomeState {}

class IncomeInitial extends IncomeState {}

class IncomeLoading extends IncomeState {}

class IncomeSuccess extends IncomeState {
  final List<IncomingOrderModel> orders;

  IncomeSuccess(this.orders);
}

class IncomeError extends IncomeState {
  final String message;

  IncomeError(this.message);
}