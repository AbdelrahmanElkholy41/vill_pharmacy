import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_app/features/setting_pharmacy/data/repositories/pharmacy_repositories.dart';
import 'package:pharmacy_app/features/setting_pharmacy/presentation/Cubit/register_pharmacy_state.dart';

import '../../data/models/pharmacy_modal.dart';

class PharmacyCubit extends Cubit<PharmacyState> {
  final PharmacyRepositoryImpl repository;

  PharmacyCubit({
    required this.repository,
  }) : super(PharmacyInitial());

  Future<void> registerPharmacy(
      PharmacyModel pharmacy,
      ) async {
    emit(PharmacyLoading());

    try {
      final result = await repository.registerPharmacy(
        pharmacy,
      );

      emit(PharmacySuccess(result));
    } catch (e) {
      emit(PharmacyError(e.toString()));
    }
  }
}