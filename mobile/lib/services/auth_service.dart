import 'package:easy_read/models/user.dart';
import 'package:easy_read/shared/helpers.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dio/dio.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  var dio = Dio();
  String? userToken = "user fake token";
  String address = "https://192.168.0.101:7144";

  Future<String?> signInWithGoogle() async {
    try {
      await _googleSignIn.signOut();
      Map<String, dynamic> userObject = {};
      var result = await _googleSignIn.signIn();
      var googleKey = await result?.authentication;

      userObject.addAll({
        "accessToken": googleKey?.accessToken,
        "name": result?.displayName,
      });

      //TODO: Communicate with our backend and get user token
      //TODO: Assign the user token to [userToken]

      return userToken;
    } on PlatformException catch (e) {
      e.log();

      e.code.log();
    } catch (e) {
      // TODO: Handle all errors properly
      // Other errors
      e.log();
    }
    return null;
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

  Future<String?> signUpWithPhoneNumberAndPassword() async => "user token";

  Future<String?> getVerificationCode({required User user}) async {
    try {
      var formData = FormData.fromMap(user.toMap());
      Response response = await dio.post(
        "$address/api/user/verifyUser",
        data: formData,
      );

      return response.data;
    } catch (e) {
      // TODO: Handle all errors properly
      e.log();
      return null;
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
