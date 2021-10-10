import 'package:arcopen_enquirer/http/requests/login_request.dart';
import 'package:arcopen_enquirer/http/requests/register_request.dart';
import 'package:arcopen_enquirer/http/responses/login_response.dart';
import 'package:arcopen_enquirer/http/responses/profile_response.dart';
import 'package:arcopen_enquirer/http/responses/register_response.dart';
import 'package:arcopen_enquirer/utils/repositories/base_repository.dart';
import 'package:dio/dio.dart';

class AuthRepository extends BaseRepository {
  Future<LoginResponse> login({required LoginRequest request}) async {
    try {
      final Response response = await client.post(path: "/login/", args: request.toJson());
      return LoginResponse.fromJson(response.data);
    } on DioError catch (e) {
      throw new Exception(this.extractErrorMessageFromDioError(e));
    }
  }

  Future<RegisterResponse> register({required RegisterRequest request}) async {
    try {
      final Response response = await client.post(path: "/enquirerSignup/", args: request.toJson());
      return RegisterResponse.fromJson(response.data);
    } on DioError catch (e) {
      throw new Exception(this.extractErrorMessageFromDioError(e));
    }
  }

  Future<String> sendForgotPasswordRequest(data) async {
    try {
      final Response response = await client.post(path: "/forgotpassword/", args: data);
      return response.data["success"];
    } on DioError catch (e) {
      throw new Exception(this.extractErrorMessageFromDioError(e));
    }
  }

  Future<ProfileResponse> createProfile({required FormData data}) async {
    try {
      final Response response = await client.post(path: "/enquirerProfile/", args: data);
      return ProfileResponse.fromJson(response.data);
    } on DioError catch (e) {
      throw new Exception(this.extractErrorMessageFromDioError(e));
    }
  }
}
