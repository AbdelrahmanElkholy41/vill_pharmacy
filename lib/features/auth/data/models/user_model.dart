import '../../domain/entities/user_entity.dart';

class UserModel {
  final String id;
  final String fullName;
  final String email;
  final String phone;
  final String role;
  final String status;
  final String? pharmacyId;
  final DateTime? deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.role,
    required this.status,
    required this.pharmacyId,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      role: json['role'] as String,
      status: json['status'] as String,
      pharmacyId: json['pharmacyId'] as String?,
      deletedAt: json['deletedAt'] != null
          ? DateTime.parse(json['deletedAt'] as String)
          : null,
      createdAt: DateTime.parse(
        json['createdAt'] as String,
      ),
      updatedAt: DateTime.parse(
        json['updatedAt'] as String,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'role': role,
      'status': status,
      'pharmacyId': pharmacyId,
      'deletedAt': deletedAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

// =========================
// Model -> Entity
// =========================

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      name: fullName,
      phone: phone,
      role: _mapRole(role),
      pharmacyId: pharmacyId,
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
