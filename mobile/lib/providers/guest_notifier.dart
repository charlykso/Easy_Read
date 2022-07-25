import 'package:easy_read/models/user.dart';
import 'package:easy_read/providers/data/guest_state.dart';
import 'package:easy_read/services/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final guestNotifierProvider =
    StateNotifierProvider.autoDispose<GuestNotifier, GuestState>(
        (ref) => GuestNotifier());

class GuestNotifier extends StateNotifier<GuestState> {
  GuestNotifier() : super(GuestState());

  final AuthService _authService = AuthService();

  void setInputCode({required String userInput, required int index}) =>
      state = state.copyWith(
        inputCode: _replaceCharAt(
          character: userInput,
          index: index,
          oldString: state.inputCode ?? "",
        ),
        countdownController: state.countdownAnimationController,
      );

  Future<String?> requestVerificationCodeFromApi() async =>
      await _authService.getVerificationCode(
        user: User(
          firstName: state.firstName,
          lastName: state.lastName,
          email: state.emailAddress,
          phoneNumber: state.phoneNumber?.completeNumber,
          password: state.password,
        ),
      );

  void resetOnResend() {
    setCanResend(value: false);
    state.countdownAnimationController?.value = 0.0;
    state.countdownAnimationController?.forward();
  }

  void setCanResend({required bool value}) => state = state.copyWith(
        canResend: value,
        countdownController: state.countdownAnimationController,
        inputCode: "",
      );

  /// Replace character at a specific index of a string
  ///
  /// Return `character` if `oldString` is empty
  ///
  /// Append `character` to `oldString` if `index` is equal to length of `oldString`
  String _replaceCharAt(
      {required String character,
      required int index,
      required String oldString}) {
    if (oldString.isEmpty) {
      return character;
    } else if (index == oldString.length) {
      return oldString.substring(0, index) + character;
    } else if (index > oldString.length) {
      throw RangeError('index value is out of range');
    }

    return oldString.substring(0, index) +
        character +
        oldString.substring(index + 1);
  }

  void reset() => state = GuestState();
}
