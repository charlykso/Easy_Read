import 'package:easy_read/models/user.dart';
import 'package:easy_read/services/dio_exception.dart';
import 'package:easy_read/shared/helpers.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dio/dio.dart';

class AuthService {
  String? userToken;
  String address = "https://192.168.0.100:7144";
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  AuthService()
      : _dio = Dio(
          BaseOptions(
            connectTimeout: 10000,
          ),
        );

  late final Dio _dio;

  Map<String, String> _handleDioError(DioError e) =>
      {"error": DioException.fromDioError(e).toString()};

  Future<Map?> signInWithGoogle() async {
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

      userToken = response.data;

      return <String, dynamic>{"success": userToken};
    } on DioError catch (e) {
      return _handleDioError(e);
    }
  }

  Future<String?> signInWithFacebook() async {
    try {
      Map<String, dynamic> userObject = {};
      final LoginResult result = await FacebookAuth.instance.login();
      AccessToken? accessToken;

      accessToken = result.accessToken;

      final Map<String, dynamic> userData =
          await FacebookAuth.instance.getUserData();

      //TODO: Replace all logs with error handling
      //- Remove this on release build
      if (accessToken != null) {
        accessToken.toJson().forEach((key, value) => "$key is $value".log());
        userData.forEach((key, value) => "$key is $value".log());
      }

      userObject.addAll({
        "accessToken": accessToken?.token,
        "name": userData["name"],
      });

      //TODO: Communicate with our backend and get user token
      //TODO: Assign the user token to [userToken]

      return userToken;
    } on PlatformException catch (e) {
      e.log();
      e.code.log();
    } catch (e) {
      // TODO: Handle all errors properly
      e.log();
    }
    return null;
  }

  Future<String?> signInWithPhoneNumberAndPassWord() async => "user token";

  Future<Map?> signUpWithPhoneNumberAndPassword({required User u}) async {
    try {
      var formData = FormData.fromMap(u.toMap());
      Response result =
          await _dio.post("$address/api/createuser", data: formData);

      return <String, dynamic>{"success": result.data};
    } on DioError catch (e) {
      return _handleDioError(e);
    }
  }

  Future<String?> getVerificationCode({required User u}) async {
    try {
      var formData = FormData.fromMap(u.toMap());
      Response response = await _dio.post(
        "$address/api/user/verifyuser",
        data: formData,
      );

      return response.data;
    } on DioError catch (e) {
      final String message = DioException.fromDioError(e).toString();
      return message;
    }
  }

  Future<String?> signOut() async {
    // Sign out from our api

    // Sign out from google
    await _googleSignIn.signOut();

    // Sign out from facebook
    await FacebookAuth.instance.logOut();

    return "success";
  }
}
