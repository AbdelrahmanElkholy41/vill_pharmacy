import '../models/create_order_request_model.dart';

abstract class OrderRemoteDataSource {
  Future<OrderModel> createOrder(
      CreateOrderRequestModel  request,
      );
}