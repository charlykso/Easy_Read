class User {
  int? id;
  String? token;
  String? tokenExpiration;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? password;

  User({
    this.id,
    this.token,
    this.tokenExpiration,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.password,
  });

  User.fromMap(Map<String, dynamic> info) {
    id = info['id'];
    token = info['token'];
    tokenExpiration = info['tokenExpiration'];
    firstName = info['firstName'];
    lastName = info['lastName'];
    email = info['email'];
    phoneNumber = info['phone_number'];
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        "firstname": firstName,
        "lastname": lastName,
        "email": email,
        "phone_no": phoneNumber,
        "password": password,
      };

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
}
