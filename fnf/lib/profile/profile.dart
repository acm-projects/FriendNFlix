import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fnf/profile/followingPage.dart';
import 'package:fnf/profile/topWatchedPage.dart';
import 'package:fnf/services/Post/PostMethods.dart';

import '../services/Post/Post.dart';
import 'PostOverview.dart';
import '../services/database.dart';
import '../services/navBar.dart';
import 'followerPage.dart';

class Profile extends StatefulWidget {
  Profile({Key? key, required this.userID}) : super(key: key);
  String userID;

  @override
  State<Profile> createState() => _profilePage();
}

class _profilePage extends State<Profile> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  dynamic user = null;
  String? username;
  int followers = 0;
  int following = 0;
  int postCount = 0;
  String path = '';
  List<Widget> favoriteShowWidgets = [];

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

    await setAvatarPath();
    buildFavoriteShowWidgets();
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


  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFAF3037),
          elevation: 0, // set the height of the AppBar
          automaticallyImplyLeading: false,
          toolbarHeight: 80,
          actions: [
            ColorFiltered( // MESSAGE BUTTON AND ICON
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
              child: IconButton(
                onPressed: () {

                },
                icon: const Icon(Icons.settings),
                iconSize: 50, // increase the size of the icon
              ),
            ),
          ],
        ),
        bottomNavigationBar: navBar(),
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 30),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
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
                                      MaterialPageRoute(builder: (context) => Profile(userID: widget.userID)),
                                    );
                                  },
                              icon: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage(path), fit: BoxFit.cover)),
                              ))),
                    ]),

                Container(
                  child: Center(
                    child: Text(
                      username ?? "",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                //Row(children: [Text(' ')]),

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
                      followers
                          .toString(),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
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
                        List postRefs = await PostMethods().getCurrentUsersPostRefs();

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
                          child:
                          Padding(
                            padding: EdgeInsets.only(
                              top: 10,
                              left: 15,
                              right: 15,
                              bottom: 10
                            ),
                            child: const Text(
                            " ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        )
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

                Container(
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
                Row(children: const [Text(' ')]),
              ]),
        ));
  }
}
