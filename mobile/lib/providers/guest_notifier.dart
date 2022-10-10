import 'package:easy_read/models/user.dart';
import 'package:easy_read/models/guest.dart';
import 'package:easy_read/services/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final guestProvider = StateNotifierProvider.autoDispose<GuestNotifier, Guest>(
    (ref) => GuestNotifier());

class GuestNotifier extends StateNotifier<Guest> {
  GuestNotifier() : super(Guest());

  final AuthService _authService = AuthService();

  Future<Result> requestVerificationCodeFromApi() async =>
      await _authService.getVerificationCode(
        u: User(
          firstName: state.firstName,
          lastName: state.lastName,
          email: state.emailAddress,
          phoneNumber: state.phoneNumber?.completeNumber,
          password: state.password,
        ),
      );

  Future<Result> signUserUp() async =>
      await _authService.signUpWithPhoneNumberAndPassword(
        u: User(
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
      );

  bool validateVerificationCode() {
    if (state.verificationCode == state.userSuppliedCode) {
      return true;
    } else {
      return false;
    }
  }

  void reset() => state = Guest();
}
