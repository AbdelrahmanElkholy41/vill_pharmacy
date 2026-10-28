import '../models/order_modal.dart';

abstract class OrderRemoteDataSource {
  Future<OrderModel> createOrder(
      CreateOrderRequestModel request,
      );

  Future<List<IncomingOrderModel>> getOrders();
  Future<void> acceptOrder(String orderId, double price, int deliveryTime);
  Future<void> rejectOrder(String orderId, String reson);
  Future<void> prepareOrder(String orderId);

}


