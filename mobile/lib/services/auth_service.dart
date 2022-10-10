import 'dart:convert';

import 'package:easy_read/models/user.dart';
import 'package:easy_read/services/dio_exception.dart';
import 'package:easy_read/services/logger_interceptor.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dio/dio.dart';

class AuthService {
  String address = "https://192.168.0.106:5000";
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  AuthService()
      : _dio = Dio(
          BaseOptions(
            connectTimeout: 10000,
            receiveTimeout: 5000,
          ),
        )..interceptors.add(LoggerInterceptor());

  late final Dio _dio;

  Result _handleDioError(DioError e) => Result(
      status: ResultStatus.error,
      data: DioException.fromDioError(e).toString());

  Future<Result?> signInWithGoogle() async {
    try {
      await _googleSignIn.signOut();
      var result = await _googleSignIn.signIn();
      var googleKey = await result?.authentication;

      Map<String, dynamic> userObject = {
        "accessToken": googleKey?.accessToken,
      };

      var formData = FormData.fromMap(userObject);
      Response response =
          await _dio.post("$address/api/user/googleauth", data: formData);

      return Result(status: ResultStatus.success, data: response.data);
    } on DioError catch (e) {
      return _handleDioError(e);
    }
  }

  Future<Result> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      AccessToken? accessToken;

      accessToken = result.accessToken;

      Map<String, dynamic> userObject = {
        "accessToken": accessToken?.token,
      };

      var formData = FormData.fromMap(userObject);
      Response response =
          await _dio.post("$address/api/user/googleauth", data: formData);

      return Result(status: ResultStatus.success, data: response.data);
    } on DioError catch (e) {
      return _handleDioError(e);
    }
  }

  Future<String?> signInWithPhoneNumberAndPassWord() async => "user token";

  Future<Result> signUpWithPhoneNumberAndPassword({required User u}) async {
    try {
      var formData = FormData.fromMap(u.toMap());
      Response response = await _dio.post(
        "$address/api/user/createuser",
        data: formData,
      );
      final result = response.data;
      result['token'] = json.decode(result['token']);

      return Result(status: ResultStatus.success, data: result);
    } on DioError catch (e) {
      return _handleDioError(e);
    }
  }

  Future<Result> getVerificationCode({required User u}) async {
    try {
      var formData = FormData.fromMap(u.toMap());
      Response response = await _dio.post(
        "$address/api/user/verifyuser",
        data: formData,
      );

      return Result(status: ResultStatus.success, data: response.data);
    } on DioError catch (e) {
      return _handleDioError(e);
    }
  }

  Future<void> signOutFromSocials() async {
    // Sign out from google
    await _googleSignIn.signOut();

    // Sign out from facebook
    await FacebookAuth.instance.logOut();
  }
}

class Result {
  final ResultStatus status;
  final dynamic data;

  const Result({required this.status, required this.data});
}

enum ResultStatus {
  success,
  error,
}
