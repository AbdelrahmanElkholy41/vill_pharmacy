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

    print("REPOSITORY START");

    final loginRequest = LoginRequestModel(
      email: request.email,
      password: request.password,
    );


    print("CALL REMOTE");

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

    print("REPOSITORY START");


    final registerRequest = registerRequestModel(
      fullName: request.fullName,
      email: request.email,
      phone: request.phone,
      password: request.password,
      role: request.role,
    );


    print(request.role);
    print("CALL REMOTE");


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
    print(await localDataSource.getAccessToken());
    print(await localDataSource.getRefreshToken());
    print(await localDataSource.getUser());

    return AuthResponseEntity(
      user: response.data.user.toEntity(),
      accessToken: response.data.accessToken,
      refreshToken: response.data.refreshToken,
    );


  }

}