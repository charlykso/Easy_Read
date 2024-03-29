import 'package:intl_phone_field/phone_number.dart';

/// Stores temporary data of a guest user
class Guest {
  Guest({
    this.firstName,
    this.lastName,
    this.emailAddress,
    this.phoneNumber,
    this.password,
    this.verificationCode,
    this.canResend = false,
    this.userSuppliedCode,
  });

  // Sign Up Form States
  String? firstName;
  String? lastName;
  String? emailAddress;
  PhoneNumber? phoneNumber;
  String? password;

  /// Verification code from `AuthService`
  String? verificationCode;

  /// Verification code entered by user on `VerificationScreen`
  String? userSuppliedCode;
  bool? canResend = false;

  Guest copyWith({
    String? firstName,
    String? lastName,
    String? emailAddress,
    PhoneNumber? phoneNumber,
    String? password,
    String? verificationCode,
    bool? canResend,
    String? userSuppliedCode,
    bool? passwordVisible,
  }) {
    return Guest(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      emailAddress: emailAddress ?? this.emailAddress,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      verificationCode: verificationCode ?? this.verificationCode,
      canResend: canResend ?? this.canResend,
      userSuppliedCode: userSuppliedCode ?? this.userSuppliedCode,
    );
  }
}
