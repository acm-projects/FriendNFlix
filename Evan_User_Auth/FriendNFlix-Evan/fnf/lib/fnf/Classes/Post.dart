import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Post {

  String body = "";
  String filmTitle = "";
  int phoneLevel = 0;
  int starRating = 0;
  int watchDay = 0;
  int watchMonth = 0;
  int watchYear = 0;
  List<String> tags = [];

  Post({required this.body, required this.filmTitle, required this.phoneLevel, required this.starRating, required this.watchDay, required this.watchMonth, required this.watchYear, required this.tags});


  factory Post.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,) {
    final data = snapshot.data();

    if(data?["body"] == null) data?["body"] = "";
    if(data?["filmTitle"] == null) data?["filmTitle"] = "";
    if(data?["phoneLevel"] == null) data?["phoneLevel"] = 0;
    if(data?["starRating"] == null) data?["starRating"] = 0;
    if(data?["watchDay"] == null) data?["watchDay"] = 0;
    if(data?["watchMonth"] == null) data?["watchMonth"] = 0;
    if(data?["watchYear"] == null) data?["watchYear"] = 0;
    if(data?["tags"] == null) data?["tags"] = [];

    return Post(
        body: data?['body'],
        filmTitle: data?['filmTitle'] ,
        phoneLevel: data?['phoneLevel'],
        starRating: data?['starRating'],
        watchDay: data?['watchDay'],
        watchMonth: data?["watchMonth"],
        watchYear: data?["watchYear"],
        tags: data?["tags"]
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (body != null) "body": body,
      if (filmTitle != null) "filmTitle": filmTitle,
      if (phoneLevel != null) "phoneLevel": phoneLevel,
      if (starRating != null) "starRating": starRating,
      if (watchDay != null) "watchDay": watchDay,
      if (watchMonth != null) "watchMonth": watchMonth,
      if (watchYear != null) "watchYear": watchYear,
      if (tags != null) "tags": tags,
    };


  }
}