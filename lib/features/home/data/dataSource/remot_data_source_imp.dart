import 'package:dio/dio.dart';
import 'package:pharmacy_app/features/home/data/dataSource/remote_data_source.dart';
import 'package:pharmacy_app/features/setting_pharmacy/data/models/pharmacy_modal.dart';

import '../../../auth/data/datasource/auth_local_data_source.dart';

class NearByPharmacyRemotDataSourceImp implements NearByPharmacyRemotDataSource {
  final Dio dio;
  final AuthLocalDataSource localDataSource;

  NearByPharmacyRemotDataSourceImp(this.dio, this.localDataSource,);

  @override
  Future<List<PharmacyModel>> getNearbyPharmacy(double lat, double lng) async {
    final token = await localDataSource.getAccessToken();
    final response = await dio.get(
      "https://pharmacy-nu-ivory.vercel.app/api/v1/pharmacies/nearby?lat=$lat&lng=$lng&maxDistanceMeters=100000",
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );

    final List<dynamic> data = response.data["data"];
    return data
        .map(
          (json) => PharmacyModel.fromJson(json),
    )
        .toList();
  }
}