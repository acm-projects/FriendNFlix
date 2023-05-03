import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fnf/services/auth.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/Calendar/Calendar.dart';
import '../services/Post/CommentsView.dart';
import '../services/Post/PostMethods.dart';
import '../services/database.dart';
import '../services/navBar.dart';
import 'SearchPage.dart';
import 'login.dart';

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
  Map<String, bool> hasFavoritedFilmMap = {};
  Map<String, String> avatarPaths = {};
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

    postRefs = [];
    String loggedInUserId = user!.email!;
    var userRef = _db.collection("users").doc(loggedInUserId);
    var userSnap = await userRef.get();
    var userData = userSnap.data();
    print(userData);
    List<dynamic>? followingDynamics = userData!["following"];
    if (followingDynamics == null) followingDynamics = [];
    List<String> following = [];
    for (dynamic followingDynamic in followingDynamics) {
      following.add(followingDynamic.toString());
      var otherRef = _db.collection("users").doc(followingDynamic.toString());
      var otherSnap = await otherRef.get();
      var otherData = otherSnap.data();
      avatarPaths[followingDynamic.toString()] = otherData!["avatarPath"];
    }

    for (String followingId in following) {
      print("id");
      print(followingId);
      List? tempPostRefs = await PostMethods().getUsersPostRefs(followingId);
      if (tempPostRefs != null && tempPostRefs.isNotEmpty) {
        postRefs.addAll(await PostMethods().getUsersPostRefs(followingId));
      }
    }

    await _setInitialMapValues();
    _buildPostViewWidgets();
  }

  _setInitialMapValues() async {
    List<String> differentFilms = [];
    var userRef = _db.collection("users").doc(users!.email);
    var userSnap = await userRef.get();
    var userData = userSnap.data();
    List<dynamic>? favoritedFilmsDynamic = userData!["favoritedFilms"];
    List<String> favoritedFilms = [];

    if (favoritedFilmsDynamic != null) {
      for (dynamic item in favoritedFilmsDynamic) {
        favoritedFilms.add(item.toString());
      }
    }
    for (dynamic postRef in postRefs) {
      print("type");
      print(postRef);
      // all posts should start facing forward
      String postId = await postRef.id;
      postsShowingFront[postId] = true;
      // look at all users that have liked the given posts to see if the logged
      // in user has liked the post
      final docSnap = await postRef.get();
      final post = docSnap.data(); // Convert to Post object

      String username =
          await DatabaseService().getUsernameFromID(post.postAuthorId);

      print("username:");
      print(username);
      postAuthors[postId] = username;

      String title = post.filmTitle;
      if (differentFilms.contains(title) == false) {
        differentFilms.add(title);
        print('added film ${title}');
      }

      bool hasLikedPost = false;
      for (String user in post.likedBy!) {
        if (user == users!.email) {
          print('${user} has liked this post');
          likedPosts[postId] = true;
          hasLikedPost = true;
          break;
        } else {
          print('${user} does not match ${users!.email}');
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

    for (String film in differentFilms) {
      bool hasFavoritedFilm = false;

      for (String favoritedFilm in favoritedFilms) {
        if (film == favoritedFilm) {
          hasFavoritedFilm = true;
        }
      }

      print('hasFavorited ${film} = ${hasFavoritedFilm}');
      hasFavoritedFilmMap[film] = hasFavoritedFilm;
    }
  }

  _buildPostViewWidgets() async {
    postViewWidgets = [];

    for (dynamic postRef in postRefs) {
      final docSnap = await postRef.get();
      final post = docSnap.data(); // Convert to Post object
      String postId = postRef.id;

      Color heartColor;
      if (hasFavoritedFilmMap[post.filmTitle] == true) {
        heartColor = Colors.red;
      } else {
        heartColor = Colors.white;
      }

      // set the correct amount of stars to yellow based on user rating

      // set all the stars to grey

      List<Color> starColors = [
        Colors.grey,
        Colors.grey,
        Colors.grey,
        Colors.grey,
        Colors.grey
      ];

      String tagString = "";
      for (String s in post.tags) {
        tagString += s + ", ";
      }

      if (tagString.isNotEmpty)
        tagString = tagString.substring(0, tagString.length - 2);

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
      print("this is a post");
      print(post);
      String path = avatarPaths[post.postAuthorId]!;
      print(path);
      Widget avatarWidget = Container(
          padding: EdgeInsets.all(0.0),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Color(0xFFAF3037), width: 2)),
          child: IconButton(
              padding: EdgeInsets.all(0),
              constraints: BoxConstraints(),
              iconSize: 40,
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => Profile(userID: widget.userID)),
                // );
              },
              icon: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage(path), fit: BoxFit.cover)),
              )));

      String? imageURL = "";

      final moviesQuery = await _db
          .collection("movies")
          .where("title", isEqualTo: post.filmTitle)
          .get();
      if (moviesQuery != null &&
          moviesQuery.docs != null &&
          moviesQuery.docs.length > 0) {
        print('reached here for post about ${post.filmTitle}');

        final movieRef = moviesQuery.docs[0];
        imageURL = movieRef.data()["posterLink"];
        if (imageURL == null) {
          print("could not find a url");
          imageURL = "";
        }
      }

      Widget imageWidget = Image.asset("assets/images/AlpinistExample.jpg",
          fit: BoxFit.fitHeight);
      if (imageURL != null && imageURL.isNotEmpty)
        imageWidget = Image.network(imageURL, fit: BoxFit.fitHeight);
      Widget postViewWidget;

      if (postsShowingFront![postId]!) {
        postViewWidget = Padding(
            padding: EdgeInsets.only(bottom: 25),
            child: Container(
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
                            SizedBox(width: 20),
                            /*Image.asset("assets/images/sampleProfile.png",
                            width: 75, height: 75), */

                            avatarWidget,
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
                        SizedBox(height: 5),
                        Container(width: 250, height: 250, child: imageWidget),
                        Row(children: [
                          SizedBox(width: 75),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black),
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
                              ))
                        ]),
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
                            SizedBox(width: 20),
                            IconButton(
                              onPressed: () async {
                                // if the likes are being updated (because the user might've)
                                // clicked the button multiple times, wait for the previous
                                // click to finish its job
                                if (_updatingLikes)
                                  return;
                                else
                                  _updatingLikes = true;

                                // if the like button is clicked, unselect the dislike
                                // button (you cannot have a like and dislike at the same
                                // time)

                                // set dislike to false
                                dislikedPosts[postId] = false;
                                await PostMethods().removeDislike(postId);

                                // if the like button was pressed when it was on, toggle
                                // it off
                                if (likedPosts[postId]!) {
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
                                color: likedPosts[postId] == true
                                    ? Colors.green
                                    : Colors.white,
                                size: 35,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                print("clicked heart button");

                                bool currentlyFavoritedFilm = false;
                                if (hasFavoritedFilmMap[post.filmTitle] ==
                                    true) {
                                  currentlyFavoritedFilm = true;
                                }

                                // toggle heart to the opposite of what it is now
                                hasFavoritedFilmMap[post.filmTitle] =
                                    !currentlyFavoritedFilm;

                                // todo toggle heart in db

                                var userRef = await _db
                                    .collection("users")
                                    .doc(users!.email);

                                if (currentlyFavoritedFilm) {
                                  await userRef.update({
                                    "favoritedFilms":
                                        FieldValue.arrayRemove([post.filmTitle])
                                  });
                                } else {
                                  await userRef.update({
                                    "favoritedFilms":
                                        FieldValue.arrayUnion([post.filmTitle])
                                  });
                                }

                                _buildPostViewWidgets();
                              },
                              icon: Icon(
                                Icons.favorite,
                                color: heartColor,
                                size: 35,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                // if the likes are being updated (because the user might've)
                                // clicked the button multiple times, wait for the previous
                                // click to finish its job
                                if (_updatingLikes)
                                  return;
                                else
                                  _updatingLikes = true;

                                // if the dislike button is clicked, unselect the like
                                // button (you cannot have a like and dislike at the same
                                // time)

                                // set like to false
                                likedPosts[postId] = false;
                                await PostMethods().removeLike(postId);

                                // if the dislike button was pressed when it was on, toggle
                                // it off
                                if (dislikedPosts[postId]!) {
                                  print(
                                      "DISLIKED POST ALREADY, TURNING OFF DISLIKE");
                                  dislikedPosts[postId] = false;
                                  await PostMethods().removeDislike(postId);
                                } else {
                                  print(
                                      "not yet disliked post, turning ON dislike");
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
                                color: dislikedPosts[postId] == true
                                    ? Colors.red
                                    : Colors.white,
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
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black),
                                  onPressed: () {
                                    print("clicked on me!!!!");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CommentsViewPage(
                                                    postRef: postRef)));
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
                    )))); // Post Front View Widget;
      } else {
        postViewWidget = Padding(
          padding: EdgeInsets.only(bottom: 25),
          child: Container(
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
                    top: 20,
                    bottom: 10,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 20),
                          avatarWidget,
                          SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              _postAuthorUsername,
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
                      Container(width: 275, height: 275, child: imageWidget),
                      Row(children: [
                        SizedBox(width: 75),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black),
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
                            ))
                      ]),
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
                        child: Padding(
                          padding: EdgeInsets.only(left: 60, right: 60),
                          child: SingleChildScrollView(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Text(
                                    'Title: ${post.filmTitle}',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )),
                                ],
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        child: Text(
                                      'Thoughts: ${post.body}',
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )),
                                  ]),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
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
                                mainAxisAlignment: MainAxisAlignment.start,
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Tags: ${tagString}',
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
                          )),
                        ),
                      ),
                    ],
                  ))),
        );
      }
      postViewWidgets.add(postViewWidget);
    }

    if (postViewWidgets.isEmpty) {
      postViewWidgets.add(Padding(
          padding: EdgeInsets.only(top: 250, left: 20, right: 20),
          child: Center(
              child: Text("Follow someone to see their posts here!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Karla")))));
    }

    setState(() {
      print("got here");
      print(postViewWidgets);
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
              child: IconButton(
                // SEARCH BUTTON AND ICON
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchPage()),
                  );
                },
                icon: const Icon(Icons.search),
                iconSize: 50, // increase the size of the icon
              ),
            ),
            ColorFiltered(
              // MESSAGE BUTTON AND ICON
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

          leading: IconButton(
            icon: Container(
              width: 55,
              height: 55,
              child:
                  Image.asset('assets/images/logo1.png', fit: BoxFit.fitHeight),
            ),
            onPressed: () {
              _auth.signOut();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
          ),
          centerTitle: true,
          title: Text(
            'FriendNFlix',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w900,
              //letterSpacing: 3.0,
              color: Colors.black,
              fontSize: 28, // increase the font size of the title
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
