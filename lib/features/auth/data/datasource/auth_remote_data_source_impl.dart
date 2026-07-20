import 'package:dio/dio.dart';

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
}