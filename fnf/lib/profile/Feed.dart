import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fnf/services/auth.dart';

import '../services/Calendar/Calendar.dart';
import '../services/Post/CommentsView.dart';
import '../services/Post/PostMethods.dart';
import '../services/navBar.dart';
import '../src/login.dart';


class FeedPage extends StatefulWidget {
  FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();

}

class _FeedPageState extends State<FeedPage> {
  final users = FirebaseAuth.instance.currentUser;
  Map<String, String> postAuthors = {};
  Map<String, bool> postsShowingFront = {};
  Map<String, bool> likedPosts = {};
  Map<String, bool> dislikedPosts = {};
  Map<String, bool> favoritedPosts = {};
  bool _updatingLikes = false;
  List<Widget> postViewWidgets = [];
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<dynamic> postRefs = [];

  final user = FirebaseAuth.instance.currentUser;
  final AuthService _auth = AuthService();

  @override
  void initState() {
    print("ayo boss");
    setUp();


    super.initState();
  }

  setUp() async {
    postRefs = await PostMethods().getCurrentUsersPostRefs();
    await _setInitialMapValues();
    _buildPostViewWidgets();
  }

  _setInitialMapValues() async {
    for (dynamic postRef in postRefs) {
      // all posts should start facing forward
      String postId = await postRef.id;

      postsShowingFront[postId] = true;


      // look at all users that have liked the given posts to see if the logged
      // in user has liked the post

      final docSnap = await postRef.get();
      final post = docSnap.data(); // Convert to Post object

      bool hasLikedPost = false;
      for (String user in post.likedBy!) {
        if (user == users!.email) {
          likedPosts[postId] = true;
          hasLikedPost = true;
          break;
        }
      }

      if (!hasLikedPost) {
        likedPosts[postId] = false;
      }


      // look at all users that have disliked the given posts to see if the
      // logged in user has disliked the current post
      bool hasDislikedPost = false;
      for (String user in post.dislikedBy!) {
        if (user == users!.email) {
          dislikedPosts[postId] = true;
          hasDislikedPost = true;
          break;
        }
      }

      if (!hasDislikedPost) {
        dislikedPosts[postId] = false;
      }

      // todo CHECK if user has favorited film
      // for(String likedUser in post.likedBy!){
      //   if(likedUser == users!.email){
      //     likedPosts[post] = true;
      //   }
      // }
    }
  }

  _buildPostViewWidgets() async {

    print("building");
    print(postRefs);
    postViewWidgets = [];

    for (dynamic postRef in postRefs) {
      print("making widget");
      final docSnap = await postRef.get();
      final post = docSnap.data(); // Convert to Post object
      String postId = postRef.id;








      // set the correct amount of stars to yellow based on user rating

      // set all the stars to grey

      List<Color> starColors = [
        Colors.grey,
        Colors.grey,
        Colors.grey,
        Colors.grey,
        Colors.grey
      ];

      // set the first n stars to grey, where n is the star rating
      for (int i = 0; i < post.starRating; i++) {
        starColors[i] = Color(0xFFFAE20D);
      }

      // get the username of the user who posted the post, or replace with anonymous
      // if it has not been fetched yet (initState will fetch them)
      String? _postAuthorUsername = postAuthors[postId];
      if (_postAuthorUsername == null || _postAuthorUsername.isEmpty) {
        _postAuthorUsername = "Anonymous";
      }

      String? imageURL = "";

      final moviesQuery = await _db.collection("movies").where("title", isEqualTo: post.filmTitle).get();
      if(moviesQuery != null && moviesQuery.docs != null && moviesQuery.docs.length > 0){
        print('reached here for post about ${post.filmTitle}');

        final movieRef = moviesQuery.docs[0];
        imageURL = movieRef.data()["posterLink"];
        if(imageURL == null) {
          print("could not find a url");
          imageURL = "";
        }
      }

      Widget imageWidget = Image.asset("assets/images/AlpinistExample.jpg", fit: BoxFit.fitHeight);
      if(imageURL != null && imageURL.isNotEmpty)
        imageWidget = Image.network(imageURL, fit: BoxFit.fitHeight);

      Widget postViewWidget;
      if (postsShowingFront![postId]!) {
        postViewWidget = Container(
            decoration: BoxDecoration(
              color: Colors.black,
              boxShadow: [
                BoxShadow(
                  blurRadius: 50,
                  spreadRadius: 5,
                  color: Colors.black.withOpacity(0.5),
                ),
              ],
            ),
            child: Padding(
                padding: EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(width: 2),
                        Image.asset("assets/images/sampleProfile.png",
                            width: 75,
                            height: 75
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            "@" + _postAuthorUsername + " posted",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                              fontSize: 21,
                              //fontStyle: FontStyle.italic,
                              //fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                    SizedBox(height: 2),
                    Container(
                        width: 250,
                        height: 250,
                        child: imageWidget
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black
                          ),
                          onPressed: () {
                            postsShowingFront[postId] = false;
                            _buildPostViewWidgets();
                          },
                          child: Text(
                            'Show details',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                              fontSize: 15,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        )),
                    SizedBox(height: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          color: starColors[0],
                          size: 50,
                        ),
                        Icon(
                          Icons.star,
                          color: starColors[1],
                          size: 50,
                        ),
                        Icon(
                          Icons.star,
                          color: starColors[2],
                          size: 50,
                        ),
                        Icon(
                          Icons.star,
                          color: starColors[3],
                          size: 50,
                        ),
                        Icon(
                          Icons.star,
                          color: starColors[4],
                          size: 50,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () async {

                            // if the likes are being updated (because the user might've)
                            // clicked the button multiple times, wait for the previous
                            // click to finish its job
                            if(_updatingLikes) return;
                            else _updatingLikes = true;

                            // if the like button is clicked, unselect the dislike
                            // button (you cannot have a like and dislike at the same
                            // time)

                            // set dislike to false
                            dislikedPosts[postId] = false;
                            await PostMethods().removeDislike(postId);

                            // if the like button was pressed when it was on, toggle
                            // it off
                            if(likedPosts[postId]!){
                              print("LIKED POST ALREADY, TURNING OFF LIKE");
                              likedPosts[postId] = false;
                              await PostMethods().removeLike(postId);
                            } else {
                              print("not yet liked post, turning ON like");
                              // the user had not liked the post then clicked the
                              // button so toggle like ON
                              likedPosts[postId] = true;
                              await PostMethods().addLike(postId);
                            }
                            _updatingLikes = false;
                            _buildPostViewWidgets();
                          },
                          icon: Icon(
                            Icons.thumb_up,
                            color: likedPosts[postId] == true ? Colors.green : Colors.white,
                            size: 35,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            print("clicked heart button");
                          },
                          icon: Icon(
                            Icons.favorite,
                            color: /* _userHasFavorited ? Colors.pink :*/ Colors.white,
                            size: 35,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {

                            // if the likes are being updated (because the user might've)
                            // clicked the button multiple times, wait for the previous
                            // click to finish its job
                            if(_updatingLikes) return;
                            else _updatingLikes = true;

                            // if the dislike button is clicked, unselect the like
                            // button (you cannot have a like and dislike at the same
                            // time)

                            // set like to false
                            likedPosts[postId] = false;
                            await PostMethods().removeLike(postId);

                            // if the dislike button was pressed when it was on, toggle
                            // it off
                            if(dislikedPosts[postId]!){
                              print("DISLIKED POST ALREADY, TURNING OFF DISLIKE");
                              dislikedPosts[postId] = false;
                              await PostMethods().removeDislike(postId);
                            } else {
                              print("not yet disliked post, turning ON dislike");
                              // the user had not disliked the post then clicked the
                              // button so toggle dislike ON
                              dislikedPosts[postId] = true;
                              await PostMethods().addDislike(postId);
                            }

                            await post.toFirestore();

                            _updatingLikes = false;
                            _buildPostViewWidgets();
                          },
                          icon: Icon(
                            Icons.thumb_down,
                            color: dislikedPosts[postId] == true ? Colors.red : Colors.white,
                            size: 35,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height:
                      60, // Adjust this value to move the widget down more or less
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child:
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black
                              ),
                              onPressed: (){
                                print("clicked on me!!!!");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => CommentsViewPage(postRef: postRef))
                                );
                              },
                              child: Text(
                                'View Comment Section ',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
            )

        ); // Post Front View Widget;
      } else {
        postViewWidget = Container(
            decoration: BoxDecoration(
              color: Colors.black,
              boxShadow: [
                BoxShadow(
                  blurRadius: 50,
                  spreadRadius: 5,
                  color: Colors.black.withOpacity(0.5),
                ),
              ],
            ),
            child: Padding(
                padding: EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/sampleProfile.png',
                          width: 75,
                          height: 75,
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            '@alexa_r posted',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                              fontSize: 21,
                              //fontStyle: FontStyle.italic,
                              //fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                    SizedBox(height: 2),
                    Container(
                        width: 275,
                        height: 275,
                        child: imageWidget
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black
                          ),
                          onPressed: () {
                            print("show less details PLEASE!");
                            postsShowingFront[postId] = true;
                            _buildPostViewWidgets();
                          },
                          child: Text(
                            'Show less details',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                              fontSize: 15,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        )),
                    SizedBox(height: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          color: starColors[0],
                          size: 40,
                        ),
                        Icon(
                          Icons.star,
                          color: starColors[1],
                          size: 40,
                        ),
                        Icon(
                          Icons.star,
                          color: starColors[2],
                          size: 40,
                        ),
                        Icon(
                          Icons.star,
                          color: starColors[3],
                          size: 40,
                        ),
                        Icon(
                          Icons.star,
                          color: starColors[4],
                          size: 40,
                        ),
                      ],
                    ),
                    SizedBox(
                      height:
                      150, // move up and down (the review info that's being displayed)
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Title: ${post.filmTitle}',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Thoughts ${post.body}',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Phone Level: ${post.phoneLevel}',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Watch Date:  ${post.watchMonth} / ${post.watchDay} / ${post.watchYear}',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Tags: TODO',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )
            )
        );
      }
      postViewWidgets.add(postViewWidget);
    }


    if(postViewWidgets.isEmpty){
      print("taggg");
      postViewWidgets.add(
        Center(
          child: Text("Follow someone to see their posts here!")
        )
      );
    }

    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xFFFFF7F5),
          elevation: 0,
          toolbarHeight: 90, // set the height of the AppBar
          actions: [
            ColorFiltered(
              colorFilter: const ColorFilter.mode(
                Color(0xFFAF3037),
                BlendMode.srcIn,
              ),
              child: IconButton( // SEARCH BUTTON AND ICON
                onPressed: () {},
                icon: const Icon(Icons.search),
                iconSize: 50, // increase the size of the icon
              ),
            ),
            ColorFiltered( // MESSAGE BUTTON AND ICON
              colorFilter: const ColorFilter.mode(
                Color(0xFFAF3037),
                BlendMode.srcIn,
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CalendarPage()),
                  );
                },
                icon: const Icon(Icons.calendar_month_rounded),
                iconSize: 50, // increase the size of the icon
              ),
            ),
          ],
          leading: SizedBox(
              width: 300, // increase the width of the logo
              height: 300, // increase the height of the logo
              child: IconButton(
                icon: Image.asset(
                  'assets/images/logo1.png',
                  width: 300,
                  height: 300,
                ), onPressed: () {
                _auth.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Login()),
                );
              },
              )
          ),
          centerTitle: true,
          title: const Text(
            'FriendNFlix',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 36, // increase the font size of the title
            ),
          ),
        ),
        bottomNavigationBar: navBar(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.0000000015, // move everything down by x percent
              ),
              SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.only(bottom: 30, left: 20, right: 20),
                child: Column(children: postViewWidgets),
              )
            ],
          ),
        ));
  }
}