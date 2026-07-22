import '../models/login_request_model.dart';
import '../models/login_response_modal.dart';
import '../models/regester_request_modal.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> login(LoginRequestModel request);
  Future<AuthResponseModel> register(registerRequestModel request);
}
