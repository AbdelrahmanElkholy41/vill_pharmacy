import '../../../setting_pharmacy/data/models/pharmacy_modal.dart';

abstract class PharmacyNearState {}

class PharmacyNearInitial extends PharmacyNearState {}

class PharmacyNearLoading extends PharmacyNearState {}

class PharmacyNearSuccess extends PharmacyNearState {
  final List<PharmacyModel> pharmacies;

  PharmacyNearSuccess(this.pharmacies);
}

class PharmacyNearError extends PharmacyNearState {
  final String message;

  PharmacyNearError(this.message);
}