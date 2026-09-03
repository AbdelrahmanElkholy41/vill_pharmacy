import '../datasource/remot_data_source.dart';
import '../models/create_order_request_model.dart';

class OrderRepositoryImpl {
  final OrderRemoteDataSource remoteDataSource;

  OrderRepositoryImpl(this.remoteDataSource);

  Future<OrderModel> createOrder(
      CreateOrderRequestModel request,
      ) async {
    return await remoteDataSource.createOrder(request);
  }

  Future<List<IncomingOrderModel>> getOrders() async {
    return await remoteDataSource.getOrders();
  }
  Future<void> acceptOrder(String orderId) async {
    return await remoteDataSource.acceptOrder(orderId);
  }
  Future<void> rejectOrder(String orderId) async {
    return await remoteDataSource.rejectOrder(orderId);
}
}