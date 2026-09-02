import 'package:dio/dio.dart';
import 'package:pharmacy_app/features/auth/data/datasource/auth_local_data_source.dart';
import 'package:pharmacy_app/features/setting_pharmacy/data/models/pharmacy_modal.dart';

import 'edit_pharmacy_remote_date_source.dart';

class EditPharmacyRemoteDataSourceImpl
    implements EditPharmacyRemoteDataSource {
  final Dio dio;
  final AuthLocalDataSource localDataSource;

  EditPharmacyRemoteDataSourceImpl(
      this.dio,
      this.localDataSource,
      );

  @override
  Future<PharmacyModel> registerPharmacy(
      PharmacyModel request,
      ) async {
    final token = await localDataSource.getAccessToken();

    try {
      print('------------------');

      final response = await dio.post(
        "https://pharmacy-nu-ivory.vercel.app/api/v1/pharmacies/register",
        data: request.toJson(),
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),

      );
      print(response.data);

      return PharmacyModel.fromJson(
        response.data["data"],
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        final message = e.response?.data['message'];

        throw Exception(message);
      }

      rethrow;
    }
  }
  @override
  Future<PharmacyModel> getPharmacy() async {
    final token = await localDataSource.getAccessToken();

    try {
      final response = await dio.get(
        "https://pharmacy-nu-ivory.vercel.app/api/v1/pharmacies/my",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      return PharmacyModel.fromJson(
        response.data['data'],
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        final message = e.response?.data['message'];
        throw Exception(message);
      }

      rethrow;
    }
  }
}