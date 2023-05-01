import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fnf/profile/topWatchedPage.dart';
import 'package:fnf/services/database.dart';

import '../services/Post/Post.dart';
import '../services/Post/PostMethods.dart';
import '../services/navBar.dart' as navBar;
import 'PostOverview.dart';
import 'followerPage.dart';
import 'followingPage.dart';

class otherProfile extends StatefulWidget {
  otherProfile({Key? key, required this.userID,}) : super(key: key);
  String userID;

  @override
  State<otherProfile> createState() => _otherProfileState();
}

class _otherProfileState extends State<otherProfile> {
  final loggedInUser = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Widget profileWidget = Container();
  dynamic user = null;
  String? username;
  int followers = 0;
  int following = 0;
  int postCount = 0;
  List<Widget> favoriteShowWidgets = [];
  String path = '';

  setUserWithID(String userID) async {
    user = await DatabaseService().getUserWithID(widget.userID);
    setState(() => user = user);
  }
  getUsername(String userID) async {
    username = await DatabaseService().getUsernameFromID(widget.userID);
    setState(() => username = username);
  }

  getPostCount(String userID) async {
    postCount = await DatabaseService().getPostCount(widget.userID);
    setState(() => postCount = postCount);
  }
  getFollowers(String userID) async {
    followers = await DatabaseService().getNumFollowersFromID(widget.userID);
    setState(() => followers = followers);
  }
  getFollowing(String userID) async {
    following = await DatabaseService().getNumFollowingFromID(widget.userID);
    setState(() => following = following);
  }
  Follow(String userID) async {
    final loggedInUser = FirebaseAuth.instance.currentUser?.uid;

    dynamic followed = DatabaseService().follow(loggedInUser!, userID);
    if(followed) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => otherProfile(userID: widget.userID)),
      );
    }
  }

  @override
  void initState() {
    setUp();
    super.initState();
  }

  setUp()async {
    await getUsername(widget.userID);
    await setUserWithID(widget.userID);
    await getFollowers(widget.userID);
    await getFollowing(widget.userID);
    await getPostCount(widget.userID);
    await buildFavoriteShowWidgets();
    await setAvatarPath();
    buildProfileWidget();

    setState(() {

    });
  }

  setAvatarPath(){
    var userData = user.data();
    var pathDynamic = userData["avatarPath"];
    if(pathDynamic != null) path = pathDynamic.toString();
  }

  buildFavoriteShowWidgets() async {
    favoriteShowWidgets = [];
    List<Post> posts = await PostMethods().getUsersPost(widget.userID);
    PostMethods().sortPostsByMostStars(posts); // sorts post with highest stars being at the front
    List<String> highlyRatedFilms = [];

    Map<String, double> filmAverageStarRating = {};
    Map<String, int> filmAmountOfPosts = {};
    for(Post post in posts){
      int? amountOfPosts = filmAmountOfPosts[post.filmTitle];
      if(amountOfPosts == null) amountOfPosts = 0;

      amountOfPosts += 1;
      filmAmountOfPosts[post.filmTitle] = amountOfPosts;

      double? score = filmAverageStarRating[post.filmTitle];
      if(score == null) score = 0;

      score += post.starRating.toDouble();

      filmAverageStarRating[post.filmTitle] = score;
    }

    for(var entry in filmAverageStarRating.entries){
      double starValue = entry.value;
      int? denominator = filmAmountOfPosts[entry.key];
      if(denominator == null) denominator = 1;

      filmAverageStarRating[entry.key] = starValue / denominator;

      starValue /= denominator;
      if(starValue >= 4)
        highlyRatedFilms.add(entry.key);
    }

    // for(Post post in posts){
    //   if(post.starRating < 4) break;
    //   if(highlyRatedFilms.contains(post.filmTitle)) continue;
    //   else highlyRatedFilms.add(post.filmTitle);
    // }

    print("printing highly rated films");
    print(highlyRatedFilms);
    for(String film in highlyRatedFilms){
      var movieQuerySnapshot = await _db.collection("movies").where(
          "title", isEqualTo: film
      ).get();

      if(movieQuerySnapshot.docs == null) continue;

      var movie = movieQuerySnapshot.docs[0];
      print("movie!!!");
      print(movie);
      print("data!!!");
      print(movie.data());

      Widget filmWidget =
      Padding(
          padding: EdgeInsets.only(
              left: 20,
              right: 20
          ),
          child: Container(
              width: 100,
              height: 100,

              child: Image.network(movie.data()["posterLink"], fit: BoxFit.cover)
          )
      );
      favoriteShowWidgets.add(filmWidget);
      print("pay attention");
      print('added widget for ${movie.data()["title"]}');
    }
    setState(() {

    });
  }

  buildProfileWidget() async {
    print(user);


    var userRef = _db.collection("users").doc(widget.userID);

    user = await userRef.get();
    var userData = user.data();
    print("printing data");
    print(userData);
    List<dynamic>? userFollowers = userData["followers"];

    // top

    if (userFollowers == null) userFollowers = [];
    List<String> userFollowersIds = [];


    for (var follower in userFollowers) {
      userFollowersIds.add(follower);
    }



    Widget buttonToDisplay = Container();
  if (user.id == loggedInUser!.email) {
    buttonToDisplay = SizedBox(
      width:110,
      height: 35
    );
  }
  else if (!userFollowersIds.contains(loggedInUser!.email)) {
    print("making follow button");
    // make button follow button
    buttonToDisplay = ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent),
        onPressed: () async {
          print("tag");
          await userRef.update({
            "followers": FieldValue.arrayUnion([loggedInUser!.email])
          });

          // add userRef(id) to current user's following
          var loggedInUserRef =
          _db.collection("users").doc(loggedInUser!.email);
          await loggedInUserRef.update({
            "following": FieldValue.arrayUnion([userRef.id])
          });

          // do the opposite for unfollow button

          print("second tag");

          followers += 1;
          buildProfileWidget();
          setState(() {});
        },
        child: SizedBox(
            width: 75,
            height: 35,
            child: Center(
                child: Text(
                  "Follow",
                  style: TextStyle(fontSize: 18),
                ))));
  } else {
    // make button unfollow button
    print("making unfollow button");
    buttonToDisplay = ElevatedButton(
        style:
        ElevatedButton.styleFrom(backgroundColor: Colors.grey),
        onPressed: () async {
          await userRef.update({
            "followers": FieldValue.arrayRemove([loggedInUser!.email])
          });

          // add userRef(id) to current user's following
          var loggedInUserRef =
          _db.collection("users").doc(loggedInUser!.email);
          await loggedInUserRef.update({
            "following": FieldValue.arrayRemove([userRef.id])
          });

          // do the opposite for unfollow button

          buildProfileWidget();
          followers -= 1;
          setState(() {});
        },
        child: SizedBox(
            width: 75,
            height: 35,
            child: Center(
                child: Text(
                  "Unfollow",
                  style: TextStyle(fontSize: 18),
                ))));
  }


    profileWidget = Scaffold(
        bottomNavigationBar: navBar.navBar(),
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 80,
                  color: Color(0xFFAF3037),
                ),

                SizedBox(
                  height: 20,
                ),

                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                        //shape: RoundedRectangleBorder(
                        //borderRadius: BorderRadius.all(Radius.circular(15.0))),
                        style:
                        ElevatedButton.styleFrom(

                          shadowColor: Colors.white,
                          backgroundColor: Colors.white.withOpacity(0),
                          elevation: 0,
                        ),
                        child: SizedBox(
                          width:75,
                            height: 35,
                            child: Center(
                          child: Text(
                          "Follow",
                          style: TextStyle(
                              color: Colors.white, fontSize: 17, fontWeight: FontWeight.w700),
                        ))),
                        onPressed: () {
                          // call database to do follow method
                          // check if database returns true, then push back to this page to reload numbers

                        },
                      ),
                      Container(
                          padding: EdgeInsets.all(0.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Color(0xFFAF3037), width: 2)),
                          child: IconButton(
                              padding: EdgeInsets.all(3),
                              constraints: BoxConstraints(),
                              iconSize: 135,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => otherProfile(userID: widget.userID)),
                                );
                              },
                              icon: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage(path), fit: BoxFit.cover)),
                              ))),
                      buttonToDisplay,
                      // ElevatedButton(
                      //     //shape: RoundedRectangleBorder(
                      //     //borderRadius: BorderRadius.all(Radius.circular(15.0))),
                      //   style:
                      //       ElevatedButton.styleFrom(
                      //         backgroundColor: Color(0xFFAF3037),
                      //       ),
                      //     child: const Text(
                      //       "Follow",
                      //       style: TextStyle(
                      //           color: Colors.white, fontSize: 17, fontWeight: FontWeight.w700),
                      //     ),
                      //     onPressed: () {
                      //       // call database to do follow method
                      //       // check if database returns true, then push back to this page to reload numbers
                      //
                      //     },
                      //   ),
                    ],
                ),

                Container(
                  child: Center(
                    child: Text(
                      username ?? "",
                      //widget.userID,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                //
                //
                //
                //
                Row(children: [
                  //Spacer(),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(18, 10, 40, 0),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Followers(userRef: user, userID: widget.userID)),
                      );
                    },
                    child: Text(
                      followers.toString(),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                          ),
                    ),
                  ),
                  //Spacer(),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(3, 10, 55, 0),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Following(userRef: user, userID: widget.userID!)),
                      );
                    },
                    child: Text(
                      following
                          .toString(), // NEED TO FIX NULL CALL ON DATA PROBLEM
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  //Spacer(),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 55, 0),
                  ),
                  TextButton(
                      onPressed:() async {
                        List postRefs = await PostMethods().getUsersPostRefs(widget.userID);


                        print("posts?");
                        print(postRefs);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PostsOverviewPage(postRefs: postRefs)),
                        );
                      },
                      child: Text(
                        postCount.toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
                  const Spacer()
                ]),
                //),

                Row(children: const [
                  Spacer(),
                  Text(
                    ' Followers',
                    style: TextStyle(
                        color: Colors.black45,
                        fontSize: 17,
                        fontWeight: FontWeight.w700),
                  ),
                  Spacer(),
                  Text(
                    'Following',
                    style: TextStyle(
                        color: Colors.black45,
                        fontSize: 17,
                        fontWeight: FontWeight.w700),
                  ),
                  Spacer(),
                  Text(
                    'Posts',
                    style: TextStyle(
                        color: Colors.black45,
                        fontSize: 17,
                        fontWeight: FontWeight.w700),
                  ),
                  Spacer()
                ]),

                Row(children: const [Text(' ')]),

                Container(
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        height: 100,
                        width: 370,
                        color: const Color(0xFFEAE2B7).withOpacity(0.4),
                        child: Container(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 10,
                                left: 15,
                                right: 15,
                                bottom: 10
                            ),
                            child: const Text(
                                "big head, big dreams, big bank account 🤑",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Row(children: const [Text(' ')]),

                Container(
                  child: Align(
                    alignment: Alignment(-0.75, 0.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TopList(userRef: null)),
                        );
                      },
                      child: Text(
                        "Favorites",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                Row(children: const [Text(' ')]),

                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 10,
                          right: 10
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: favoriteShowWidgets),
                    )
                ),

                Row(children: const [Text(' ')]),

                /*
                Container(
                  child: const Align(
                    alignment: Alignment(-0.75, 0.0),
                    child: Text(
                      "Average Rating",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),


                Row(children: const [Text(' ')]),

                Container(
                  child: Align(
                    alignment: const Alignment(-0.35, 0.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(45),
                      child: Container(
                        height: 40,
                        width: 325,
                        color: const Color(0xFFEAE2B7).withOpacity(0.4),
                      ),
                    ),
                  ),
                ),
                 */

                Row(children: const [Text(' ')]),

                /*Container(
                  child: const Align(
                    alignment: Alignment(-0.75, 0.0),
                    child: Text(
                      "Achievements",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                Row(children: const [Text(' ')]),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      color: Colors.black,
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      color: Colors.black,
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      color: Colors.black,
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      color: Colors.black,
                    ),
                  ],
                ),
                Row(children: const [Text(' ')]), */
              ]),
        ));
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return profileWidget;
  }
}
