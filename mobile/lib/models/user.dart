class User {
  int? id;
  String? lastName;
  String? firstName;
  String? email;
  String? phoneNumber;

  User(this.id, this.lastName, this.firstName, this.email, this.phoneNumber);

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lastName = json['lastName'];
    firstName = json['firstName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
  }
}
