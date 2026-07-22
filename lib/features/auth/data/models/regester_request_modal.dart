import '../../domain/entities/user_entity.dart';

class registerRequestModel {
  final String fullName;
  final String email;
  final String phone;
  final String password;
  final UserRole role;

  registerRequestModel({
    required this.email,
    required this.password,
    required this.fullName,
    required this.phone,
    required this.role,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'password': password,
      'role': role.name,
    };
  }

}
