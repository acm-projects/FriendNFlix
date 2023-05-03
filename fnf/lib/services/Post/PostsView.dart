import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fnf/services/database.dart';

import '../../profile/PostOverview.dart';
import '../navBar.dart';
import 'CommentsView.dart';
import 'PostMethods.dart';

class PostsViewPage extends StatefulWidget {
  PostsViewPage({Key? key, required this.postRefs}) : super(key: key);
  List<dynamic> postRefs;

  @override
  State<PostsViewPage> createState() => _PostsViewPageState();
}

class _PostsViewPageState extends State<PostsViewPage> {
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

  setUp() async {
    await _setInitialMapValues();
    await _buildPostViewWidgets();
  }

  @override
  void initState() {
    setUp();

    super.initState();
  }

  _setInitialMapValues() async {
    List<String> differentFilms = [];
    var userRef = _db.collection("users").doc(users!.email);
    var userSnap = await userRef.get();
    var userData = userSnap.data();
    List<dynamic>? favoritedFilmsDynamic = userData?["favoritedFilms"];
    if(favoritedFilmsDynamic == null) favoritedFilmsDynamic = [];
    List<String> favoritedFilms = [];

    for (dynamic item in favoritedFilmsDynamic) {
      favoritedFilms.add(item.toString());
    }
    print('favoritedFilms = ${favoritedFilms}');

    for (dynamic postRef in widget.postRefs) {
      // postAuthors[postId] = await DatabaseService().getUsernameFromID(authorid);
      // all posts should start facing forward
      String postId = await postRef.id;

      postsShowingFront[postId] = true;

      // look at all users that have liked the given posts to see if the logged
      // in user has liked the post

      final docSnap = await postRef.get();
      final post = docSnap.data(); // Convert to Post object

      String username = await DatabaseService().getUsernameFromID(post.postAuthorId);

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

    for (dynamic postRef in widget.postRefs) {
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

      String postAuthorId = post.postAuthorId;
      var userRef = _db.collection("users").doc(postAuthorId);
      var userSnap = await userRef.get();
      var userData = userSnap.data();
      String path = userData!["avatarPath"];

      String tagString = "";
      for(String tag in post.tags){
        tagString += tag + ", ";
      }

      if(tagString.length >= 2){
        tagString = tagString.substring(0, tagString.length - 2);
      }

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
                        SizedBox(width: 10),
                        avatarWidget,
                        SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            "@" + _postAuthorUsername,
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
                    Container(width: 250, height: 250, child: imageWidget),
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
                            '                      Show details',
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
                            if (hasFavoritedFilmMap[post.filmTitle] == true) {
                              currentlyFavoritedFilm = true;
                            }

                            // toggle heart to the opposite of what it is now
                            hasFavoritedFilmMap[post.filmTitle] =
                            !currentlyFavoritedFilm;

                            // todo toggle heart in db

                            var userRef =
                            await _db.collection("users").doc(users!.email);

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
                                        builder: (context) => CommentsViewPage(
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
                ))); // Post Front View Widget;
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
                        SizedBox(width: 20),
                        avatarWidget,
                        SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            "@" + _postAuthorUsername,
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
                            '                      Show less details',
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
                                'Thoughts: ${post.body}',
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
                      ),
                    ),
                  ],
                )));
      }
      postViewWidgets.add(postViewWidget);
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
          title: Text(""),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Color(0xFFAF3037),
                size: 30,
              )),
          // title: Text("Posts",
          //     style: TextStyle(
          //         color: Color(0xFFAF3037),
          //         fontSize: 25,
          //         fontWeight: FontWeight.bold)),
          // centerTitle: true,
          backgroundColor: Colors.white,
          actionsIconTheme: const IconThemeData(
            color: Colors.green,
            size: 30,
          ),
          elevation: 0,
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
              /*ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent),
                onPressed: () async {
                  print("todo");
                  //await PostMethods().sortPostRefsByMostStars(widget.postRefs);
                  _buildPostViewWidgets();
                },
                child: Text('Sort by stars'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent),
                onPressed: () async {
                  // await PostMethods().sortPostRefsByMostRecent(widget.postRefs);
                  _buildPostViewWidgets();
                },
                child: Text('Sort by date'),
              ),


               */
              Padding(
                padding: EdgeInsets.only(bottom: 30, left: 20, right: 20),
                child: Column(children: postViewWidgets),
              )
            ],
          ),
        ));
  }
}