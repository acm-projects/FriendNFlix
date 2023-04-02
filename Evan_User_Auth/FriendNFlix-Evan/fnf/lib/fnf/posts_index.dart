import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Classes/Post.dart';
import 'PostMethods.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class PostIndexPage extends StatefulWidget {
  const PostIndexPage({Key? key}) : super(key: key);

  @override
  State<PostIndexPage> createState() => _PostIndexState();
}

class _PostIndexState extends State<PostIndexPage> {
  // attributes
  List <Post> posts = [];
  List<Widget> postWidgets = [];
  PostMethods postMethods = PostMethods();
  // constructor
  _PostIndexState() {
    _setPosts();
  }

  // this method sets the _posts attribute
  _setPosts() async {
    posts = await postMethods.getCurrentUsersPosts();
    // posts = await postMethods.getAllPosts();
    postWidgets = [];
    if(posts.isEmpty) postWidgets.add(Text("No posts :("));
    else{
      for(Post post in posts){
        postWidgets.add(Text(post.body));
      }
    }


    this.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VIEWING ALL POSTS'),
      ),
      body: SafeArea(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(children: postWidgets),
              Center(
                  child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent),
                onPressed: () {
                  _setPosts();
                },
                child: const Text('Refresh posts'),
              )),
            ] // children
            ),
      ),
    );
  }
}
