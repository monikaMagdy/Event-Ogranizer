class UserModel {
  String userID;
  final String firstName;
  final String lastName;
  //DateTime _birthdate;
  final String username;
  final String email;
  final String password;
  final String socialID;
  final String phoneNumber;

//constructor
  // ignore: sort_constructors_first
  UserModel({
    this.userID,
    this.firstName,
    this.lastName,
    this.username,
    this.email,
    this.password,
    this.socialID,
    this.phoneNumber,
  });
}
