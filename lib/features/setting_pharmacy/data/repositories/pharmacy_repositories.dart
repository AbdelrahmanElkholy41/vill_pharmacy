import 'package:pharmacy_app/features/setting_pharmacy/data/datasource/edit_pharmacy_remote_date_source.dart';

import '../models/pharmacy_modal.dart';


class PharmacyRepositoryImpl  {
  final EditPharmacyRemoteDataSource remoteDataSource;

  PharmacyRepositoryImpl(this.remoteDataSource);


  Future<PharmacyModel> registerPharmacy(PharmacyModel request) async {
    return await remoteDataSource.registerPharmacy(request);
  }
}