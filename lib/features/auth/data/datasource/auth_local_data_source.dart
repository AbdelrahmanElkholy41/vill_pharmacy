import '../../domain/entities/user_entity.dart';

abstract class AuthLocalDataSource {
  Future<void> saveAccessToken(String token);

  Future<void> saveRefreshToken(String token);

  Future<String?> getAccessToken();

  Future<String?> getRefreshToken();

  Future<void> clearTokens();
  Future<void> saveUser(UserEntity user);

  Future<UserEntity?> getUser();
}