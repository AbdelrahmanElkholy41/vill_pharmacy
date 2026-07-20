import 'user_model.dart';

class AuthResponseModel {
  final bool success;
  final String message;
  final AuthDataModel data;

  AuthResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      success: json['success'],
      message: json['message'],
      data: AuthDataModel.fromJson(json['data']),
    );
  }
}


class AuthDataModel {
  final UserModel user;
  final String accessToken;
  final String refreshToken;

  AuthDataModel({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
  });


  factory AuthDataModel.fromJson(Map<String, dynamic> json) {
    return AuthDataModel(
      user: UserModel.fromJson(json['user']),
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }
}