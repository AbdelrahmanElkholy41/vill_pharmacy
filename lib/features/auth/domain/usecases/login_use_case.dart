import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {

  final AuthRepository repository;

  LoginUseCase(this.repository);


  Future<AuthResponseEntity> call(LoginEntity request) {

    return repository.login(request);

  }
}