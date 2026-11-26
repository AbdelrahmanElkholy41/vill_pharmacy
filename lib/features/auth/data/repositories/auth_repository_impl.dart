import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

import '../datasource/auth_local_data_source.dart';
import '../datasource/auth_remote_data_source.dart';
import '../models/login_request_model.dart';
import '../models/regester_request_modal.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {

  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl(
      this.remoteDataSource,
      this.localDataSource,
      );


  @override
  Future<AuthResponseEntity> login(LoginEntity request) async {


    final loginRequest = LoginRequestModel(
      email: request.email,
      password: request.password,
    );



    final response = await remoteDataSource.login(loginRequest);

    await localDataSource.saveAccessToken(
      response.data.accessToken,
    );

    await localDataSource.saveRefreshToken(
      response.data.refreshToken,
    );

    await localDataSource.saveUser(
      response.data.user.toEntity(),
    );

    return AuthResponseEntity(
      user: response.data.user.toEntity(),
      accessToken: response.data.accessToken,
      refreshToken: response.data.refreshToken,
    );

  }


  @override
  Future<AuthResponseEntity> register(RegisterEntity request) async {



    final registerRequest = registerRequestModel(
      fullName: request.fullName,
      email: request.email,
      phone: request.phone,
      password: request.password,
      role: request.role, address: request.address,

    );

    final response = await remoteDataSource.register(registerRequest);


    await localDataSource.saveAccessToken(
      response.data.accessToken,
    );

    await localDataSource.saveRefreshToken(
      response.data.refreshToken,
    );

    await localDataSource.saveUser(
      response.data.user.toEntity(),
    );

    return AuthResponseEntity(
      user: response.data.user.toEntity(),
      accessToken: response.data.accessToken,
      refreshToken: response.data.refreshToken,
    );


  }
  @override
  Future<void> logout() async {
    final token = await localDataSource.getAccessToken();
    final retoken = await localDataSource.getRefreshToken();

    if (retoken != null) {

    }
    if (token != null) {
      await remoteDataSource.logout(token);
    }

    await localDataSource.clearTokens();
  }

}