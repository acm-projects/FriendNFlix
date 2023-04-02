import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fnf/fnf/posts_index.dart';

import 'fnf/Calendar.dart';
import 'fnf/test_firestore_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final users = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text('${users?.email}', style: TextStyle(fontSize: 40),),

            const SizedBox(height: 10,),
            Center(
              child: Container (

              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orangeAccent),
              onPressed: (){
                FirebaseAuth.instance.signOut();
              },
              child: Text(
                  'Log Out'
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              onPressed: () {
                print("User wants to create a post!");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreatePostPage()),
                );
              }, // todo onPressed functionality
              child: Text(
                  'Create Post'
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PostIndexPage()),
                );
              },
              child: Text(
                  'View All Posts'
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CalendarPage()),
                );
              },
              child: Text(
                  'Calendar'
              ),
            ),
          ],
        ),
      ),
    );
  }
}
