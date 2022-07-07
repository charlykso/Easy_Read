import 'package:easy_read/shared/helpers.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  String? userToken = "user fake token";

  Future<String?> signInWithGoogle() async {
    try {
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
    }
    return null;
  }

  Future<String?> signInWithFacebook() async => "user token";

  Future<String?> signInWithPhoneNumberAndPassWord() async => "user token";

  Future<String?> signUpWithPhoneNumberAndPassword() async => "user token";

  Future<String?> signOut() async {
    // Sign out from our api

    // Sign out from google
    _googleSignIn.signOut();

    // Sign out from facebook

    return null;
  }
}
