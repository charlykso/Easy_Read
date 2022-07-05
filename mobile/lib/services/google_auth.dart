import 'dart:io';

import 'package:easy_read/shared/helpers.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth {
  static final _googleSignIn = GoogleSignIn();

  /// Retrieve access token from google
  static Future<Map<String, dynamic>?> signIn() async {
    try {
      late Map<String, dynamic> userObject = {};

      var result = await _googleSignIn.signIn();
      var googleKey = await result!.authentication;
      userObject.addAll({
        'accessToken': googleKey.accessToken,
        'idToken': googleKey.idToken,
        'displayName': result.displayName ?? '',
        'email': result.email,
        'id': result.id,
        'avatarUrl': result.photoUrl ?? '',
        'serverAuthCode': result.serverAuthCode ?? '',
      });

      return userObject;
    } on SocketException catch (e) {
      e.log();
      // if (PlatformException(code: "network_error")) {
      //   "yeah platform here".log();
      // }
    }
    return null;
  }

  static Future<GoogleSignInAccount?> signOut() => _googleSignIn.signOut();

  static GoogleSignInAccount? currentUser() => _googleSignIn.currentUser;
}
