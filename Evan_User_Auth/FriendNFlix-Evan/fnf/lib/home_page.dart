import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fnf/fnf/PostMethods.dart';
import 'package:fnf/fnf/PostsOverview.dart';
import 'package:fnf/fnf/WantToWatch.dart';
import 'package:fnf/fnf/posts_index.dart';

import 'GetFavoriteShows.dart';
import 'fnf/Calendar.dart';
import 'fnf/Classes/Post.dart';
import 'fnf/CreatePost1.dart';
import 'fnf/DatabaseServices.dart';
import 'fnf/Follower.dart';
import 'fnf/Following.dart';
import 'fnf/SearchPage.dart';
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
            Text(
              '${users?.email}',
              style: TextStyle(fontSize: 40),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Container(),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent),
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              child: Text('Log Out'),
            ),
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              onPressed: () {
                print("User wants to create a post!");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreatePostPage()),
                );
              }, // todo onPressed functionality
              child: Text('Create Post'),
            ),
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.tealAccent),
              onPressed: () {
                print("User wants to create a post!");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreatePost1()),
                );
              }, // todo onPressed functionality
              child: Text('REAL Create a Post'),
            ),
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PostIndexPage()),
                );
              },
              child: Text('View All Posts'),
            ),
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CalendarPage()),
                );
              },
              child: Text('Calendar'),
            ),
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
              onPressed: () async {
                // get posts to pass to PostsOverviewPage to display
                List postRefs = await PostMethods().getCurrentUsersPostRefs();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PostsOverviewPage(postRefs: postRefs)),
                );
              },
              child: Text('Posts Overview for Logged In User'),
            ),
            ElevatedButton(
              style:
              ElevatedButton.styleFrom(backgroundColor: Colors.yellowAccent),
              onPressed: () async {
                // get posts to pass to PostsOverviewPage to display
                List postRefs = await PostMethods().getCurrentUsersPostRefs();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WantToWatchPage()),
                );
              },
              child: Text('Want To Watch'),
            ),
            ElevatedButton(
              style:
              ElevatedButton.styleFrom(backgroundColor: Colors.lightGreenAccent),
              onPressed: () async {
                // get posts to pass to PostsOverviewPage to display
                List postRefs = await PostMethods().getCurrentUsersPostRefs();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SearchPage()),
                );
              },
              child: Text('Search Page'),
            ),
            ElevatedButton(
              style:
              ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              onPressed: () async {
                // get posts to pass to PostsOverviewPage to display
                List postRefs = await PostMethods().getCurrentUsersPostRefs();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GetFavoriteShowsPage()),
                );
              },
              child: Text('Get favorite shows'),
            ),
            ElevatedButton(
              style:
              ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
              onPressed: () async {
                // get posts to pass to PostsOverviewPage to display
                var userRef = await DatabaseService().getUserWithID(users!.email!);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Followers(userID: users!.email, userRef: userRef,)),
                );
              },
              child: Text('Followers Page'),
            ),
            ElevatedButton(
              style:
              ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
              onPressed: () async {
                // get posts to pass to PostsOverviewPage to display
                var userRef = await DatabaseService().getUserWithID(users!.email!);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Following(userID: users!.email, userRef: userRef,)),
                );
              },
              child: Text('Following Page'),
            ),
          ],
        ),
      ),
    );
  }
}
