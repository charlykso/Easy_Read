import 'package:flutter/widgets.dart';

@immutable
class User {
  const User({
    required this.id,
    required this.token,
    required this.tokenExpiration,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.password,
  });

  final int id;
  final String token;
  final String tokenExpiration;
  final String firstName;
  final String lastName;
  final String? email;
  final String? phoneNumber;
  final String? password;

  factory User.fromJson(Map<String, Object?> json) {
    return User(
      id: json['id'] as int,
      token: json['token'] as String,
      tokenExpiration: json['tokenExpiration'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      password: json['password'] as String?,
    );
  }

  Map<String, Object?> toJson() {
    return {
      "id": id,
      "token": token,
      "tokenExpiration": tokenExpiration,
      "firstname": firstName,
      "lastname": lastName,
      "email": email,
      "phone_no": phoneNumber,
      "password": password,
    };
  }

  User copyWith({
    String? token,
    String? tokenExpiration,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? password,
  }) {
    return User(
      id: id,
      token: token ?? this.token,
      tokenExpiration: tokenExpiration ?? this.tokenExpiration,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
    );
  }

  @override
  String toString() {
    return 'User('
        'id: $id,'
        'token: $token,'
        'tokenExpiration: $tokenExpiration,'
        'firstName: $firstName,'
        'lastName: $lastName,'
        'email: $email,'
        'phoneNumber: $phoneNumber,'
        'password: $password,'
        ')';
  }

  @override
  bool operator ==(Object other) {
    return other is User &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.token == token &&
        other.tokenExpiration == tokenExpiration &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.password == password;
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      id,
      token,
      tokenExpiration,
      firstName,
      lastName,
      email,
      phoneNumber,
      password,
    );
  }
}
