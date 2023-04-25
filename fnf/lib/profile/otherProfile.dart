import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fnf/profile/topWatchedPage.dart';
import 'package:fnf/services/database.dart';

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
  Widget profileWidget = Container();
  dynamic user = null;
  String? username;
  int followers = 0;
  int following = 0;
  int postCount = 0;
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
    // print(widget.userID);
    //
    // getUsername(widget.userID);
    // setUserWithID(widget.userID);
    // getFollowers(widget.userID);
    // getFollowing(widget.userID);
    //
    // getPostCount(widget.userID);
    // buildProfileWidget();

    //Follow(widget.userID);
    super.initState();
  }

  setUp()async {
    await getUsername(widget.userID);
    await setUserWithID(widget.userID);
    await getFollowers(widget.userID);
    await getFollowing(widget.userID);

    await getPostCount(widget.userID);
    buildProfileWidget();
  }
  buildProfileWidget() async {

    profileWidget = Scaffold(
        floatingActionButton: FloatingActionButton.large(
          elevation: 0,
          backgroundColor: Color(0xFFAF3037),
          //shape: RoundedRectangleBorder(
              //borderRadius: BorderRadius.all(Radius.circular(15.0))),
          child: const Text(
            "Follow",
            style: TextStyle(
                color: Colors.white, fontSize: 17, fontWeight: FontWeight.w700),
          ),
          onPressed: () {
            // call database to do follow method
            // check if database returns true, then push back to this page to reload numbers



          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        bottomNavigationBar: navBar.navBar(),
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
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
                      CircleAvatar(
                        minRadius: 70,
                        backgroundColor: Color(0xFFAF3037),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 68.0,
                          child: ElevatedButton(
                            child: const Icon(
                              Icons.person,
                              size: 100.0,
                              color: Colors.black,
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(20),
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        otherProfile(userID: widget.userID)),
                              );
                            },
                          ),
                        ),
                      ),
                    ]),

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
                        "Favorite Shows",
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 90,
                      width: 90,
                      color: const Color(0xFFEAE2B7).withOpacity(0.4),
                    ),
                    Container(
                      height: 90,
                      width: 90,
                      color: const Color(0xFFEAE2B7).withOpacity(0.4),
                    ),
                    Container(
                      height: 90,
                      width: 90,
                      color: const Color(0xFFEAE2B7).withOpacity(0.4),
                    ),
                  ],
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
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return profileWidget;
  }
}
