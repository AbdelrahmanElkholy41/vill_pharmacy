import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

import '../datasource/auth_remote_data_source.dart';
import '../models/login_request_model.dart';
import '../models/regester_request_modal.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {

  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserEntity> login(LoginEntity request) async {

    print("REPOSITORY START");

    final loginRequest = LoginRequestModel(
      email: request.email,
      password: request.password,
    );

    print("CALL REMOTE");

    final response = await remoteDataSource.login(loginRequest);

    print("REMOTE DONE");

    return response.data.user.toEntity();
  }

  Future<UserEntity> register(RegisterEntity request) async {

    print("REPOSITORY START");

    final registerRequest = registerRequestModel(

      fullName: request.fullName,
      email: request.email,
      phone: request.phone,
      password: request.password,
      role: request.role

    );

    print(request.role.name);
    print("CALL REMOTE");

    final response = await remoteDataSource.register(registerRequest);

    print("REMOTE DONE");

    return response.data.user.toEntity();
  }


  }
