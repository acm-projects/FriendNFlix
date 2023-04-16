import 'dart:convert';

List<Users> usersFromJson(String str) => List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));
String usersToJson(List<Users> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Users {
  Users({
    this.uid = '',
    this.email = '',
    this.username = '',
  });

  String uid;
  String email;
  String username;

  int followers = 0;
  int following = 0;
  String bio = '';

  static Users fromJson(Map<String, dynamic> json) => Users(
    uid: json["id"],
    email: json["email"],
    username: json["username"],
    //followers: json["followers"],
    //following: json["following"],
    //bio: json["bio"],
  );

  Map<String, dynamic> toJson() => {
    "id": uid,
    "email": email,
    "username": username,
    "followers": followers,
    "following": following,
  };
}