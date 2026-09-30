import 'package:pharmacy_app/features/setting_pharmacy/data/models/pharmacy_modal.dart';

abstract class NearByPharmacyRemotDataSource{

  Future<List<PharmacyModel>>getNearbyPharmacy(double lat,double lng);
}