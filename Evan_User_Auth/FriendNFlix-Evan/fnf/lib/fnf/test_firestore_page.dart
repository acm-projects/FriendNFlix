import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fnf/fnf/PostMethods.dart';
import 'package:fnf/fnf/posts_index.dart';
import 'package:fnf/fnf/printMap.dart';

import 'Classes/Post.dart';

/*
* this page allows a logged in user to create a post and puts it in firestore
* */

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  var _makingPost = false;

  // connect to firestore db
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final users = FirebaseAuth.instance.currentUser;

  final _postBodyInputController = TextEditingController();

  @override
  initState() {
    super.initState();

    _postBodyInputController.addListener(() {}); // todo add listener
  }

  @override
  dispose() {
    _postBodyInputController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create A Post ${users?.email}!'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    width: MediaQuery.of(context).size.width * .8,
                    child: TextField(
                        controller: _postBodyInputController,
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 3,
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Write your thoughts',
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 25),
                          border: InputBorder.none,
                        )))),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent),
                onPressed: () async {
                  if (_makingPost)
                    return;
                  else
                    _makingPost = true;

                  String postBody = _postBodyInputController.text.trim();

                  // do nothing if string is empty
                  if (postBody.isEmpty) {
                    _makingPost = false;
                    return;
                  }

                  // if we get here, we will make a post

                  _postBodyInputController.clear(); // clear text from input

                  // final postInfo = <String, dynamic>{
                  //   "body": postBody,
                  // };

                  // note: all values except the body are hard coded for right now
                  Post newPost = Post(
                      body: postBody, filmTitle: "Some film", starRating: 3,
                      watchDay: 26, watchMonth: 2, watchYear: 2023, phoneLevel: 90,
                  tags : []);

                  PostMethods postMethods = PostMethods();
                  var result = await postMethods.addPostToFirestore(newPost);

                  print(result);
                  Navigator.pop(context);

                  _makingPost = false;
                  },
                child: Text('Post')),
          ],
        ),
      ),
    );
  }
}
