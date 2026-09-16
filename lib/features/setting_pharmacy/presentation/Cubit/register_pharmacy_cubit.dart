import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pharmacy_app/features/setting_pharmacy/data/repositories/pharmacy_repositories.dart';
import 'package:pharmacy_app/features/setting_pharmacy/presentation/Cubit/register_pharmacy_state.dart';

import '../../data/models/pharmacy_modal.dart';

class PharmacyCubit extends Cubit<PharmacyState> {
  final PharmacyRepositoryImpl repository;
  final FlutterSecureStorage storage;

  PharmacyCubit({
    required this.repository,
    required this.storage,
  }) : super(PharmacyInitial());

  Future<void> registerPharmacy(
      PharmacyModel pharmacy,
      ) async {
    emit(PharmacyLoading());

    try {
      final result = await repository.registerPharmacy(pharmacy);

      await storage.write(
        key: 'pharmacy',
        value: jsonEncode(result.toJson()),
      );

      emit(PharmacySuccess(result));
    } catch (e) {
      emit(PharmacyError(e.toString()));
    }
  }

  Future<void> getPharmacy() async {
    emit(PharmacyLoading());

    try {
      // 1. حاول تجيب الصيدلية من الكاش
      final cachedPharmacy = await storage.read(
        key: 'pharmacy',
      );

      if (cachedPharmacy != null) {
        final pharmacy = PharmacyModel.fromJson(
          jsonDecode(cachedPharmacy),
        );

        print('Pharmacy loaded from cache');

        emit(PharmacySuccess(pharmacy));
        return;
      }

      // 2. لو مفيش كاش، هات من الـ API
      final result = await repository.getPharmacy();

      // 3. خزّنها في الكاش
      await storage.write(
        key: 'pharmacy',
        value: jsonEncode(result.toJson()),
      );

      print('Pharmacy loaded from API and cached');

      emit(PharmacySuccess(result));
    } catch (e) {
      emit(PharmacyError(e.toString()));
    }
  }
}