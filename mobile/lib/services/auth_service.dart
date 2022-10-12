import 'dart:convert';

import 'package:easy_read/models/user.dart';
import 'package:easy_read/providers/loading_notifier.dart';
import 'package:easy_read/services/dio_exception.dart';
import 'package:easy_read/services/logger_interceptor.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dio/dio.dart';

class AuthService {
  String address = "https://192.168.0.106:5000";
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  AuthService()
      : _dio = Dio(
          BaseOptions(
            connectTimeout: 10000,
            receiveTimeout: 15000,
          ),
        )..interceptors.add(LoggerInterceptor());

  late final Dio _dio;

  Result _handleDioError(DioError e) => Result(
      status: ResultStatus.error,
      data: DioException.fromDioError(e).toString());

  Future<Result> signInWithGoogle(WidgetRef ref) async {
    try {
      // interact with google api
      final googleResponse = await _googleSignIn.signIn();
      if (googleResponse == null) {
        ref.read(loadingProvider.notifier).turnOff();
      }
      final googleKey = await googleResponse!.authentication;

      // login to the app api
      var formData = FormData.fromMap({"token": googleKey.accessToken});
      Response response =
          await _dio.post("$address/api/user/googleauth", data: formData);
      final result = response.data;
      result['token'] = json.decode(result['token']);

      return Result(status: ResultStatus.success, data: result);
    } on DioError catch (e) {
      return _handleDioError(e);
    }
  }

  Future<Result> signInWithFacebook(WidgetRef ref) async {
    try {
      // interact with facebook api
      final facebookResponse = await FacebookAuth.instance.login();
      final loadingNotifier = ref.read(loadingProvider.notifier);

      switch (facebookResponse.status) {
        case LoginStatus.cancelled:
          loadingNotifier.turnOff();
          break;
        case LoginStatus.failed:
          loadingNotifier.turnOff();
          return Result(
              status: ResultStatus.error, data: facebookResponse.message);
        default:
      }

      // login to the app api
      var formData =
          FormData.fromMap({'token': facebookResponse.accessToken!.token});
      Response response =
          await _dio.post("$address/api/user/facebookauth", data: formData);
      final result = response.data;
      result['token'] = json.decode(result['token']);

      return Result(status: ResultStatus.success, data: result);
    } on DioError catch (e) {
      return _handleDioError(e);
    }
  }

  Future<Result> signInWithPhoneNumberAndPassWord(
      {required String phoneNumber, required String password}) async {
    try {
      Response response = await _dio.post(
        '$address/api/login',
        data: {'phone_no': phoneNumber, 'password': password},
      );
      final result = response.data;
      result['token'] = json.decode(result['token']);

      return Result(status: ResultStatus.success, data: result);
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return const Result(
            status: ResultStatus.error, data: "User does not exist!");
      }
      return _handleDioError(e);
    }
  }

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
