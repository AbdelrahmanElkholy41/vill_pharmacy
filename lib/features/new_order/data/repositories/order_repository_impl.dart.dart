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
}