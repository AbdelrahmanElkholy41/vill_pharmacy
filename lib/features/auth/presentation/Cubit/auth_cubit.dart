import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/datasource/auth_local_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/logout_use_case.dart';

part 'Auth_State.dart';



  class AuthCubit extends Cubit<AuthState> {
  final AuthLocalDataSource localDataSource;
  final LogoutUseCase logoutUseCase;

  AuthCubit(
  this.localDataSource,
  this.logoutUseCase,
  ) : super(AuthInitial());


  void login(UserEntity user){

    emit(
      AuthAuthenticated(
        user: user,
      ),
    );

  }
  Future<void> logout() async {
    await logoutUseCase();
    emit(AuthUnauthenticated());
  }



  Future<void> checkAuth() async {

    emit(AuthLoading());


    final token = await localDataSource.getAccessToken();

    final user = await localDataSource.getUser();


    if(token != null &&
        token.isNotEmpty &&
        user != null){

      emit(
        AuthAuthenticated(
          user: user,
        ),
      );


    }else{

      emit(AuthUnauthenticated());

    }

  }

}