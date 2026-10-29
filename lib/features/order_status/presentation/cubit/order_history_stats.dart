
import 'package:equatable/equatable.dart';

import '../../data/modal/order_history_customer.dart';


abstract class OrderHistoryState extends Equatable {
  const OrderHistoryState();

  @override
  List<Object?> get props => [];
}

class OrderHistoryInitial extends OrderHistoryState {
  const OrderHistoryInitial();
}

class OrderHistoryLoading extends OrderHistoryState {
  const OrderHistoryLoading();
}

class OrderHistorySuccess extends OrderHistoryState {
  final List<OrderHistoryModel> orders;
  final Map<String, dynamic> stats;

  const OrderHistorySuccess({
    required this.orders,
    required this.stats,
  });

  @override
  List<Object?> get props => [orders, stats];
}

class OrderHistoryFailure extends OrderHistoryState {
  final String message;

  const OrderHistoryFailure(this.message);

  @override
  List<Object?> get props => [message];
}
