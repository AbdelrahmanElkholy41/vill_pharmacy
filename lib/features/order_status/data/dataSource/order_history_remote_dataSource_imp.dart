
import 'package:dio/dio.dart';

import '../../../auth/data/datasource/auth_local_data_source.dart';
import '../modal/order_history_customer.dart';
import 'order_history_remote_dataSource.dart';

class OrderHistoryRemoteDatasourceImp
    implements OrderHistoryRemoteDatasource {
  final Dio dio;
  final AuthLocalDataSource localDataSource;

  OrderHistoryRemoteDatasourceImp(this.dio, this.localDataSource);

  @override
  Future<List<OrderHistoryModel>> getOrderHistory() async {
    final token = await localDataSource.getAccessToken();

    try {
      final response = await dio.get(
        'https://pharmacy-nu-ivory.vercel.app/api/v1/orders/my',
        queryParameters: {
          'page': 2,
          'limit': 10,
          'sortOrder': 'desc',
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      final data = response.data['data'] as Map<String, dynamic>;
      final items = data['items'] as List;

      return items
          .map(
            (item) => OrderHistoryModel.fromJson(
          item as Map<String, dynamic>,
        ),
      )
          .toList();
    } on DioException {
      rethrow;
    }
  }
}
