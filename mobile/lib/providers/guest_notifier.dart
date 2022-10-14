import 'package:easy_read/models/guest.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final guestProvider = StateNotifierProvider.autoDispose<GuestNotifier, Guest>(
    (ref) => GuestNotifier());

class GuestNotifier extends StateNotifier<Guest> {
  GuestNotifier() : super(Guest());

  void setCanResend({required bool value}) => state = state.copyWith(
        canResend: value,
      );

  bool validateVerificationCode() {
    if (state.verificationCode == state.userSuppliedCode) {
      return true;
    } else {
      return false;
    }
  }

  void reset() => state = Guest();

  @override
  void dispose() {
    reset();
    super.dispose();
  }
}
