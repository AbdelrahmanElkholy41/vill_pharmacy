import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_app/features/new_order/data/repositories/order_repository_impl.dart.dart';

import 'income_state.dart';



class IncomeCubit extends Cubit<IncomeState> {
  final OrderRepositoryImpl repository;

  IncomeCubit({
    required this.repository,
  }) : super(IncomeInitial());

  Future<void> getOrders() async {
    emit(IncomeLoading());

    try {
      final orders = await repository.getOrders();
      emit(IncomeSuccess(orders));
    } catch (e) {
      emit(IncomeError(e.toString()));
    }
  }
}

