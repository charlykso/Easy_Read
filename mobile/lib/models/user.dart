class User {
  int? id;
  String? token;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? password;

  User({
    this.id,
    this.token,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.password,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    token = json['token'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    password = json['password'];
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
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? password,
  }) {
    return User(
      id: id,
      token: token ?? this.token,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
    );
  }
}
