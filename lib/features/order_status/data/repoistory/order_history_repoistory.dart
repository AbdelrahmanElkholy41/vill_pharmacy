import '../dataSource/order_history_remote_dataSource.dart';
import '../modal/order_history_customer.dart';

class OrderHistoryRepoistory {
  final OrderHistoryRemoteDatasource remoteDatasource;

  OrderHistoryRepoistory(this.remoteDatasource);

  Future<List<OrderHistoryModel>> getOrderHistory() {
    return remoteDatasource.getOrderHistory();
  }
  Future<void>orderDelivered(String orderId){
    return remoteDatasource.orderDelivered(orderId);
  }

}