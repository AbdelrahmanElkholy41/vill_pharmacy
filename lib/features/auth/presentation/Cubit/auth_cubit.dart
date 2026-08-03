import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/datasource/auth_local_data_source.dart';
import '../../domain/entities/user_entity.dart';

part 'Auth_State.dart';


class AuthCubit extends Cubit<AuthState>{

  final AuthLocalDataSource localDataSource;


  AuthCubit(this.localDataSource)
      : super(AuthInitial());


  void login(UserEntity user){

    emit(
      AuthAuthenticated(
        user: user,
      ),
    );

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