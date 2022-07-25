import 'package:flutter/cupertino.dart';
import 'package:intl_phone_field/phone_number.dart';

/// Stores temporary data of a guest user
class GuestState {
  GuestState({
    this.firstName,
    this.lastName,
    this.emailAddress,
    this.phoneNumber,
    this.password,
    this.verificationCode,
    this.userInputCodes,
    this.canResend = false,
    this.countdownAnimationController,
  });

  // Sign Up Form States
  String? firstName;
  String? lastName;
  String? emailAddress;
  PhoneNumber? phoneNumber;
  String? password;
  AnimationController? countdownAnimationController;

  /// Verification code from `AuthService`
  String? verificationCode;

  /// Verification code entered by user on `VerificationScreen`
  List<String?>? userInputCodes;
  bool? canResend = false;

  GuestState copyWith({
    String? firstName,
    String? lastName,
    String? emailAddress,
    PhoneNumber? phoneNumber,
    String? password,
    String? verificationCode,
    bool? canResend,
    AnimationController? countdownController,
    List<String?>? inputCodes,
  }) {
    return GuestState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      emailAddress: emailAddress ?? this.emailAddress,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      verificationCode: verificationCode ?? this.verificationCode,
      userInputCodes: inputCodes ?? userInputCodes,
      canResend: canResend ?? this.canResend,
      countdownAnimationController:
          countdownController ?? countdownAnimationController,
    );
  }
}
