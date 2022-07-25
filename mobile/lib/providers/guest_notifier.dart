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
      );

  bool validateVerificationCode() {
    String? inputCodes = state.userInputCodes?.join();
    if (state.verificationCode == inputCodes) {
      return true;
    } else {
      return false;
    }
  }

  void reset() => state = GuestState();
}
