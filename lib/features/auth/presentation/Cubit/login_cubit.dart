import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/login_use_case.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {

  final LoginUseCase loginUseCase;

  LoginCubit(this.loginUseCase) : super(LoginInitial());


  Future<void> login({
    required String email,
    required String password,
  }) async {

    print("LOGIN START: $email - $password");

    emit(LoginLoading());

    try {

      final response = await loginUseCase(
        LoginEntity(
          email: email,
          password: password,
        ),
      );


      emit(
        LoginSuccess(response),
      );


    } catch (e) {

      emit(
        LoginError(e.toString()),
      );

    }
  }
}