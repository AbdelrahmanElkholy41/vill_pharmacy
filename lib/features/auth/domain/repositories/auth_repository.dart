import '../entities/user_entity.dart';

abstract class AuthRepository {

  Future<AuthResponseEntity> login(LoginEntity request);

  Future<AuthResponseEntity> register(RegisterEntity request);

}