import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth {
  static final _googleSignIn = GoogleSignIn();

  static Future<GoogleSignInAccount?> signIn() => _googleSignIn.signIn();
  static Future<GoogleSignInAccount?> signOut() => _googleSignIn.signOut();
}
