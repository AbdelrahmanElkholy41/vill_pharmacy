import '../../data/models/pharmacy_modal.dart';

abstract class PharmacyState {}

class PharmacyInitial extends PharmacyState {}

class PharmacyLoading extends PharmacyState {}

class PharmacySuccess extends PharmacyState {
  final PharmacyModel pharmacy;

  PharmacySuccess(this.pharmacy);
}

class PharmacyError extends PharmacyState {
  final String message;

  PharmacyError(this.message);
}