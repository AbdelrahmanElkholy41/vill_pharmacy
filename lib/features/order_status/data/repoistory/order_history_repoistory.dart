import '../modal/order_history_customer.dart';

class OrderHistoryRepoistory {
  final OrderHistoryRepoistory orderHistoryRepoistoryImp;
  OrderHistoryRepoistory(this.orderHistoryRepoistoryImp);
  Future<List<OrderHistoryModel>> getOrderHistory() async {
    return await orderHistoryRepoistoryImp.getOrderHistory();
  }
}
