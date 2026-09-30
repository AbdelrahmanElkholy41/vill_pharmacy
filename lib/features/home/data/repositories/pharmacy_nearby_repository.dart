import 'package:pharmacy_app/features/home/data/dataSource/remote_data_source.dart';

import '../../../setting_pharmacy/data/models/pharmacy_modal.dart';

class PharmacyNearbyRepositoryImp {
  final NearByPharmacyRemotDataSource remoteDataSource;
  PharmacyNearbyRepositoryImp(this.remoteDataSource);
  Future<List<PharmacyModel>> getNearbyPharmacy(double lat, double lng) async {
    return remoteDataSource.getNearbyPharmacy(lat, lng);
  }
}
