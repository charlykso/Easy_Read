import 'package:easy_read/models/user.dart';
import 'package:easy_read/shared/helpers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final userNotifierProvider = StateNotifierProvider<UserNotifier, User>((ref) {
  return UserNotifier();
});

class UserNotifier extends StateNotifier<User> {
  UserNotifier() : super(User());

  final _storage = const FlutterSecureStorage();

  void saveCurrentUser({Map? userInfo}) {
    logger.d(userInfo);

    // save to user device

    // save to app state
  }
}
