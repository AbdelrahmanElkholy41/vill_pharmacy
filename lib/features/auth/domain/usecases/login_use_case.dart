import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {

  final AuthRepository repository;

  LoginUseCase(this.repository);


  Future<UserEntity> call(LoginEntity request) async {

    print("REPOSITORY CALL FROM USECASE");

    return await repository.login(request);
  }
}