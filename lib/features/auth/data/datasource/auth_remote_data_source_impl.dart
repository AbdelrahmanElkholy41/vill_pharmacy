import 'package:dio/dio.dart';
import 'package:pharmacy_app/features/auth/data/models/regester_request_modal.dart';

import '../models/login_request_model.dart';
import '../models/login_response_modal.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {

  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);


  @override
  Future<AuthResponseModel> login(LoginRequestModel request) async {

    print("REMOTE START");

    try {

      final response = await dio.post(
        'https://pharmacy-nu-ivory.vercel.app/api/v1/auth/login',
        data: {
          'email': request.email,
          'password': request.password,
        },
      );

      print("STATUS CODE: ${response.statusCode}");
      print("DATA: ${response.data}");

      return AuthResponseModel.fromJson(response.data);

    } catch(e) {

      print("REMOTE ERROR: $e");

      rethrow;
    }
  }
  @override
  Future<void> logout(String token) async {
    await dio.post(
      'https://pharmacy-nu-ivory.vercel.app/api/v1/auth/logout',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  @override
  Future<AuthResponseModel> register(registerRequestModel request) async {
    try {

      final response = await dio.post(
        'https://pharmacy-nu-ivory.vercel.app/api/v1/auth/register',
        data: {
          'fullName': request.fullName,
          'email': request.email,
          'password': request.password,
          'phone': request.phone,
          'role': request.role.name,
        },
      );
      print("-------------------------------------");
print(request.role);
      print("STATUS CODE: ${response.statusCode}");
      print("DATA: ${response.data}");

      return AuthResponseModel.fromJson(response.data);

    } catch (e) {

      if (e is DioException) {

        print("STATUS CODE: ${e.response?.statusCode}");

        print("RESPONSE DATA:");
        print(e.response?.data);

      }

      print("REMOTE ERROR: $e");

      rethrow;
    }

  }
}