import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;
  RegisterUseCase(this.repository);
  Future<UserEntity> call(RegisterEntity request) async {
    print("REPOSITORY CALL FROM USECASE");
    return await repository.register(request);
  }
}