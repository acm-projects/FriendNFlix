import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Comment {

  String text = "";
  String authorId = "";
  List<String>? likedBy = [];


  Comment({
    required this.text, required this.authorId,
    required this.likedBy});


  factory Comment.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,) {
    final data = snapshot.data();

    if(data?["text"] == null) data?["text"] = "";
    if(data?["authorId"] == null) data?["authorId"] = "";
    if(data?["likedBy"] == null) data?["likedBy"] = [];

    return Comment(
      text: data?['text'],
      authorId: data?['authorId'] ,
      likedBy: data?["likedBy"] is Iterable ? List.from(data?["likedBy"]) : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (text != null) "text": text,
      if (authorId != null) "authorId": authorId,
      if (likedBy != null) "likedBy": likedBy,
    };


  }
}
