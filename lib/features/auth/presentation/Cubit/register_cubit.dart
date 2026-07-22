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
    print("REGISTER START: $email - $password");
    emit(RegisterLoading());
    try {
      final user = await registerUseCase(
        RegisterEntity(
          fullName: fullName,
          email: email,
          password: password,
          phone: phone,
          role: role,
        ),
      );
      emit(RegisterSuccess(user));
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }

}
