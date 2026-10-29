import '../modal/order_history_customer.dart';

abstract class OrderHistoryRemoteDatasource {
  Future<List<OrderHistoryModel>> getOrderHistory();

}
