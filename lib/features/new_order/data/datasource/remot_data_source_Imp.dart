import 'package:dio/dio.dart';
import 'package:pharmacy_app/features/new_order/data/datasource/remot_data_source.dart';

import '../../../auth/data/datasource/auth_local_data_source.dart';
import '../models/create_order_request_model.dart';

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final Dio dio;
  final AuthLocalDataSource localDataSource;

  OrderRemoteDataSourceImpl(this.dio,
      this.localDataSource,);


  @override
  Future<OrderModel> createOrder(CreateOrderRequestModel request,) async {
    final token = await localDataSource.getAccessToken();

    FormData formData = FormData.fromMap({

      "details": request.details,

      if(request.pharmacyId != null)
        "pharmacyId": request.pharmacyId,

      if(request.prescriptionImage != null)
        "prescriptionImage": await MultipartFile.fromFile(
          request.prescriptionImage!.path,
        ),

    });

    final response = await dio.post(
      "https://pharmacy-nu-ivory.vercel.app/api/v1/orders",
      data: formData,
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );

    return OrderModel.fromJson(response.data["data"]);
  }

  @override
  Future<List<IncomingOrderModel>> getOrders() async {
    final token = await localDataSource.getAccessToken();

    final response = await dio.get(
      "https://pharmacy-nu-ivory.vercel.app/api/v1/orders/pharmacy/incoming",
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );

    final List<dynamic> data = response.data["data"];

    return data
        .map((json) => IncomingOrderModel.fromJson(json))
        .toList();
  }
  @override
  Future<void> acceptOrder(String orderId,double price,int deliveryTime) async {

    final token = await localDataSource.getAccessToken();
    final response = await dio.patch(
      "https://pharmacy-nu-ivory.vercel.app/api/v1/orders/$orderId/accept",
      data: {
        "price": price,
        "estimatedDeliveryMinutes":  deliveryTime,

      },
        options: Options(

        headers: {
          "Authorization": "Bearer $token",
        },

    ));

  }
  @override
  Future<void> rejectOrder(String orderId,String reson) async {

    final token = await localDataSource.getAccessToken();
    final response = await dio.patch(
        "https://pharmacy-nu-ivory.vercel.app/api/v1/orders/$orderId/reject",
        data: {
          "rejectionReason":reson
        },
        options: Options(
        headers: {
          "Authorization": "Bearer $token",

        }
        ));

  }
}
