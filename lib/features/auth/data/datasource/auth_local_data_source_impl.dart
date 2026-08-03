import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/entities/user_entity.dart';
import 'auth_local_data_source.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  static const accessTokenKey = "access_token";
  static const refreshTokenKey = "refresh_token";
  static const userKey = "user";

  @override
  Future<void> saveAccessToken(String token) async {
    await storage.write(
      key: accessTokenKey,
      value: token,
    );
  }


  @override
  Future<void> saveRefreshToken(String token) async {
    await storage.write(
      key: refreshTokenKey,
      value: token,
    );
  }

  @override
  Future<String?> getAccessToken() async {
    return await storage.read(key: accessTokenKey);
  }

  @override
  Future<String?> getRefreshToken() async {
    return await storage.read(key: refreshTokenKey);
  }

  @override
  Future<void> clearTokens() async {
    await storage.deleteAll();
  }
  @override
  Future<void> saveUser(UserEntity user) async {

    await storage.write(
      key: userKey,
      value: jsonEncode({
        "id": user.id,
        "email": user.email,
        "name": user.name,
        "phone": user.phone,
        "role": user.role.name,
      }),
    );

  }
  @override
  Future<UserEntity?> getUser() async {

    final data = await storage.read(key: userKey);

    if(data == null) return null;

    final json = jsonDecode(data);

    return UserEntity(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      phone: json['phone'],
      role: json['role'] == 'customer'
          ? UserRole.customer
          : UserRole.pharmacist,
    );

  }

}