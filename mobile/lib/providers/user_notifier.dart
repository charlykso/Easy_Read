import 'package:easy_read/models/user.dart';
import 'package:easy_read/services/secure_storage_waitress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StateNotifierProvider<UserNotifier, User>((ref) {
  return UserNotifier();
});

class UserNotifier extends StateNotifier<User> {
  UserNotifier() : super(User());

  final _storage = SecureStorageWaitress();

  void saveCurrentUser({required Map? userInfo}) {
    // save to user device

    // save to app state
  }
}
