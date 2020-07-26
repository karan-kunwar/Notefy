// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);
import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));
String userDataToJson(UserData data) => json.encode(data.toJson());
class UserData {
  UserData({
    this.apiKey,
    this.email,
    this.firstname,
    this.id,
    this.lastname,
    this.password,
    this.username,
  });

  String apiKey;
  String email;
  String firstname;
  int id;
  String lastname;
  String password;
  String username;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    apiKey: json["api_key"],
    email: json["email"],
    firstname: json["firstname"],
    id: json["id"],
    lastname: json["lastname"],
    password: json["password"],
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "api_key": apiKey,
    "email": email,
    "firstname": firstname,
    "id": id,
    "lastname": lastname,
    "password": password,
    "username": username,
  };
}
