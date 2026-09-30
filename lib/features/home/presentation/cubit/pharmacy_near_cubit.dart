import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/pharmacy_nearby_repository.dart';
import 'pharmacy_near_state.dart';

class PharmacyNearCubit extends Cubit<PharmacyNearState> {
  final PharmacyNearbyRepositoryImp repository;

  PharmacyNearCubit(this.repository) : super(PharmacyNearInitial());

  Future<void> getNearbyPharmacies(
    double lat,
    double lng,
  ) async {
    emit(PharmacyNearLoading());

    try {
      final pharmacies = await repository.getNearbyPharmacy(
        lat,
        lng,
      );

      emit(
        PharmacyNearSuccess(pharmacies),
      );
    } catch (e) {
      emit(
        PharmacyNearError(e.toString()),
      );
    }
  }
}
