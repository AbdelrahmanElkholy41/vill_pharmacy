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
  bool get isCustomer   => role == UserRole.customer;

  @override
  List<Object> get props => [id, email, name, phone, role];
}
