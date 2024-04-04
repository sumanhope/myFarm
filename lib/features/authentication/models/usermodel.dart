import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  String firstname;
  String lastname;
  final String username;
  String phonenumber;
  final String email;
  String profilepicture;

  UserModel({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.email,
    required this.phonenumber,
    required this.profilepicture,
  });

  String get fullname => '$firstname $lastname';

  static UserModel empty() => UserModel(
        id: "",
        firstname: "",
        lastname: "",
        username: "",
        email: "",
        phonenumber: "",
        profilepicture: "",
      );
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstname,
      'LastName': lastname,
      'Username': username,
      'Email': email,
      'PhoneNumber': phonenumber,
      'ProfilePicture': profilepicture,
    };
  }

  factory UserModel.fromSnapShot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstname: data['FirstName'] ?? '',
        lastname: data['LastName'] ?? '',
        username: data['Username'] ?? '',
        email: data['Email'] ?? '',
        phonenumber: data['PhoneNumber'] ?? '',
        profilepicture: data['ProfilePicture'] ?? '',
      );
    }
    return UserModel.empty();
  }
}
