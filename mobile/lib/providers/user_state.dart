import 'package:easy_read/models/user.dart';
import 'package:easy_read/services/auth_service.dart';
import 'package:easy_read/services/secure_storage_waitress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StateNotifierProvider<UserState, User?>((ref) {
  return UserState();
});

class UserState extends StateNotifier<User?> {
  UserState() : super(null);

  final SecureStorageWaitress _storage = SecureStorageWaitress();
  final AuthService _authService = AuthService();

  void saveCurrentUser({required Map? userInfo}) async {
    if (userInfo != null) {
      // save on user device
      Map<String, dynamic> newUser = {
        "id": userInfo['Id'],
        "token": userInfo['token']['token'],
        "tokenExpiration": userInfo['token']['expiration'],
        "firstName": userInfo['Firstname'],
        "lastName": userInfo['Lastname'],
        "email": userInfo['Email'],
        "phone_number": userInfo['Phone_no'],
      };

      await _storage.addItems(items: newUser);

      // save to app state
      state = User.fromMap(newUser);
    }
  }

  Future<void> login(String phone, String password) async {
    // This mocks a login attempt with phone and password
    state = await Future.delayed(
      const Duration(milliseconds: 750),
      () => User(firstName: 'test', lastName: 'user'),
    );
    String myToken = 'my-super-secret-jwt'; // Mock of a permanent storage save
  }

  Future<void> loginWithToken() async {
    // check if a token is saved
    final token = await _storage.getItem(k: "token");

    if (token == null) {
      throw const LogoutException('Nothing to do here.');
    } else {
      // token is not null, check if it has expired
      final tokenExpiration = await _storage.getItem(k: "tokenExpiration");
      // check if this datetime in milliseconds since epoch string
      DateTime currentDate = DateTime.now();
      DateTime tokenExpirationDate =
          DateTime.fromMillisecondsSinceEpoch(tokenExpiration as int);
      if (currentDate.isAfter(tokenExpirationDate)) {
        // token has expired
        throw const UnauthorizedException();
      }
    }

    // if it has not expired, login with saved credentials
    state = User.fromMap(await _storage.getAll());
  }

  Future<void> logout() async {
    // log user out from social login services via [AuthService]
    await _authService.signOutFromSocials();
    await _storage
        .removeAll(); // Remove the token from our perma storage FIRST (!!)
    // remove user from state
    state = null;
  }
}

class UnauthorizedException implements Exception {
  final String message;
  const UnauthorizedException([this.message = 'Unauthorized']);
}

class LogoutException implements Exception {
  final String message;
  const LogoutException(this.message);
}
