
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/entities/user_entity.dart';
import 'auth_local_data_source.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  static const accessTokenKey = 'access_token';
  static const refreshTokenKey = 'refresh_token';
  static const userKey = 'user';

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
    return storage.read(key: accessTokenKey);
  }

  @override
  Future<String?> getRefreshToken() async {
    return storage.read(key: refreshTokenKey);
  }

  @override
  Future<void> clearTokens() async {
    await storage.delete(key: accessTokenKey);
    await storage.delete(key: refreshTokenKey);
    await storage.delete(key: userKey);
  }

  @override
  Future<void> saveUser(UserEntity user) async {
    await storage.write(
      key: userKey,
      value: jsonEncode({
        'id': user.id,
        'email': user.email,
        'name': user.name,
        'phone': user.phone,
        'role': user.role.name,
        'pharmacyId': user.pharmacyId,
        'address': user.address,
      }),
    );
  }

  @override
  Future<UserEntity?> getUser() async {
    final data = await storage.read(key: userKey);

    if (data == null) return null;

    final json = jsonDecode(data) as Map<String, dynamic>;

    return UserEntity(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      role: _mapRole(json['role'] as String),
      pharmacyId: json['pharmacyId'] as String?,
      address: json['address'] as String?,
    );
  }

  UserRole _mapRole(String role) {
    switch (role) {
      case 'customer':
        return UserRole.customer;

      case 'pharmacist':
        return UserRole.pharmacist;

      case 'super_admin':
        return UserRole.super_admin;

      default:
        throw Exception('Unknown user role: $role');
    }
  }
}
