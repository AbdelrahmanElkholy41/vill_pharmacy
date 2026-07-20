import '../models/login_request_model.dart';
import '../models/login_response_modal.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> login(LoginRequestModel request);
}