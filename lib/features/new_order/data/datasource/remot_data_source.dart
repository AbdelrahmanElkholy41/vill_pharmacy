import '../models/create_order_request_model.dart';

abstract class OrderRemoteDataSource {
  Future<OrderModel> createOrder(
      CreateOrderRequestModel request,
      );

  Future<List<IncomingOrderModel>> getOrders();
  Future<void> acceptOrder(String orderId);
  Future<void> rejectOrder(String orderId);
}


