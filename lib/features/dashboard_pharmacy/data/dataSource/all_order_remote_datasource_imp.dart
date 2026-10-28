import 'package:dio/dio.dart';

import '../../../auth/data/datasource/auth_local_data_source.dart';
import '../modal/all_order_modal.dart';
import 'all_order_remote_datasource.dart';

class AllOrderRemoteDatasourceImp implements AllOrderRemoteDatasource {
   final Dio dio;
  final AuthLocalDataSource localDataSource;

  AllOrderRemoteDatasourceImp(this.dio, this.localDataSource);
  @override
  Future<List<AllOrderModal>> getAllOrders() async {
    final token = await localDataSource.getAccessToken();

    final response = await dio.get(
      "https://pharmacy-nu-ivory.vercel.app/api/v1/orders/pharmacy/all",
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );

    final List<dynamic> data = response.data["data"];

    return data
        .map((json) => AllOrderModal.fromJson(json))
        .toList();
  }

}