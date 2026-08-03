import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_app/features/auth/presentation/Cubit/register_state.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/register_use_case.dart';


class RegisterCubit extends Cubit<RegisterState> {

  final RegisterUseCase registerUseCase;

  RegisterCubit(this.registerUseCase) : super(RegisterInitial());


  Future<void> register({
    required String fullName,
    required String email,
    required String password,
    required String phone,
    required UserRole role,
  }) async {


    emit(RegisterLoading());

    try {

      final response = await registerUseCase(
        RegisterEntity(
          fullName: fullName,
          email: email,
          password: password,
          phone: phone,
          role: role,
        ),
      );


      emit(
        RegisterSuccess(response),
      );


    } catch (e) {

      emit(
        RegisterError(e.toString()),
      );

    }
  }

}