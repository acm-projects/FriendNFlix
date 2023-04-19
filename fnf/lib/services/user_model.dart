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

  List<String> followers = [];
  List<String> following = [];
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

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
//
// class User {
//
//   String email = "";
//   List<String> followers = [];
//   List<String> following = [];
//   String bio = "";
//   String username = "";
//
//
//
//   User({required this.email, required this.followers, required this.following, required this.username, required this.bio});
//
//
//   factory User.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
//       SnapshotOptions? options,) {
//     final data = snapshot.data();
//
//     if(data?["email"] == null) data?["email"] = "";
//     if(data?["bio"] == null) data?["bio"] = "";
//     if(data?["username"] == null) data?["username"] = "";
//     if(data?["followers"] == null) data?["followers"] = [];
//     if(data?["following"] == null) data?["following"] = [];
//
//     return User(
//         email: data?['email'],
//         filmTitle: data?['filmTitle'] ,
//         phoneLevel: data?['phoneLevel'],
//         starRating: data?['starRating'],
//         watchDay: data?['watchDay'],
//         watchMonth: data?["watchMonth"],
//         watchYear: data?["watchYear"],
//         tags: data?["tags"]
//     );
//   }
//
//   Map<String, dynamic> toFirestore() {
//     return {
//       if (body != null) "body": body,
//       if (filmTitle != null) "filmTitle": filmTitle,
//       if (phoneLevel != null) "phoneLevel": phoneLevel,
//       if (starRating != null) "starRating": starRating,
//       if (watchDay != null) "watchDay": watchDay,
//       if (watchMonth != null) "watchMonth": watchMonth,
//       if (watchYear != null) "watchYear": watchYear,
//       if (tags != null) "tags": tags,
//     };
//
//
//   }
// }
