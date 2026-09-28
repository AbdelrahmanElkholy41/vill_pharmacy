import '../models/pharmacy_modal.dart';

abstract class EditPharmacyRemoteDataSource {
  Future<PharmacyModel> registerPharmacy(PharmacyModel request);
  Future<PharmacyModel> getPharmacy();
  Future<void>pharmacyStatus(bool status);
}