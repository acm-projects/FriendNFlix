import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Comment.dart';
import 'PostMethods.dart';

class CommentsViewPage extends StatefulWidget {
  dynamic postRef;
  CommentsViewPage({Key? key, required this.postRef}) : super(key: key);

  @override
  State<CommentsViewPage> createState() => _CommentsViewPageState();
}

class _CommentsViewPageState extends State<CommentsViewPage> {

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final users = FirebaseAuth.instance.currentUser;
  TextEditingController _commentInputController = TextEditingController();
  List<Widget> _commentWidgets = [];


  _buildCommentWidgets() async {
    _commentWidgets = [];
    // get comments for given post
    var commentQuerySnapshot =
    await widget.postRef.collection("comments").get();

    dynamic commentRefs = [];
    for (var commentSnapshot in commentQuerySnapshot.docs) {
      String commentId = commentSnapshot.id;

      final ref =
      await widget.postRef.collection("comments").doc(commentId);

      final docSnap = await ref.get();
      final comment = docSnap.data(); // Convert to Comment object

      final commenterRef = await _db.collection("users").doc(comment["authorId"]);
      final commenterSnapshot = await commenterRef.get();
      final commenterData = commenterSnapshot.data();

      Widget commentWidget =
      Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 28.0,
                child: Icon(
                  Icons.person,
                  size: 30.0,
                  color: Colors.black,
                ),
              ),
              backgroundColor: Color(0xFFAF3037),
              minRadius: 30.0,
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      children: [
                        Text(
                          commenterData!["username"],
                          style: TextStyle(
                              color: Color(0xFFAF3037),
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 10),
                        Text(
                          " 3d",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ]
                  ),
                  Text(comment["text"]),
                ]
            ),
          ]
      );
      _commentWidgets.add(commentWidget);
    }
    setState((){});
  }

  @override
  void initState() {
    _commentInputController.addListener(() {print("add listener"); });
    _buildCommentWidgets();

    super.initState();
  }

  @override
  void dispose() {
    _commentInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              SizedBox(height: 80),
              Container(
                child: Align(
                  alignment: Alignment(-0.90, -1.0),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xFFAF3037),
                    size: 30,
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: Text("Comments",
                      style: TextStyle(
                          color: Color(0xFFAF3037),
                          fontSize: 25,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              Divider(
                color: Color(0xFFAF3037),
                thickness: 2,
              ),
              SizedBox(height: 15),
              Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                // ListView(
                //   children: _commentWidgets,
                // ),
                Column(
                    children: _commentWidgets
                ),
                // todo put comment widgets in here
                Divider(
                  color: Color(0xFFAF3037),
                  thickness: 2,
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: _commentInputController,
                    maxLines: 3,
                    minLines: 1,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () async {
                          String text = _commentInputController.text.trim();
                          if(text.isEmpty) return;

                          _commentInputController.clear();
                          Map<String, dynamic> comment = <String, dynamic>{
                            "authorId" : users!.email!,
                            "text": text,
                            "likedBy": []
                          };

                          await PostMethods().addCommentToFirestore(widget.postRef, comment);
                          _buildCommentWidgets();
                        },
                      ),
                      hintText: "Write a comment",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ]),
            ],
          ),
        ));
  }
}