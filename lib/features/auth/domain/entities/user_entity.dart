import 'package:equatable/equatable.dart';

enum UserRole { customer, pharmacist }

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String name;
  final String phone;
  final UserRole role;

  const UserEntity({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.role,
  });

  bool get isPharmacist => role == UserRole.pharmacist;
  bool get isCustomer => role == UserRole.customer;

  @override
  List<Object> get props => [id, email, name, phone, role];
}

class LoginEntity {
  final String email;
  final String password;

  LoginEntity({
    required this.email,
    required this.password,
  });
}

class RegisterEntity {
  final String fullName;
  final String email;
  final String phone;
  final String password;
  final UserRole role;

  RegisterEntity(
      {required this.fullName,
      required this.email,
      required this.phone,
      required this.password,
      required this.role});
}
class AuthResponseEntity {

  final UserEntity user;
  final String accessToken;
  final String refreshToken;

  AuthResponseEntity({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
  });

}