import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fnf/profile/profile.dart';
import 'package:fnf/services/database.dart';

import '../services/Post/PostMethods.dart';
import '../src/postPage.dart';
import '../services/navBar.dart';
import 'PostOverview.dart';
import 'followerPage.dart';

class Following extends StatefulWidget {

  Following({Key? key, required this.userRef, required this.userID}) : super(key: key);
  dynamic userRef;
  String userID;

  @override
  State<Following> createState() => _FollowingState();
}

class _FollowingState extends State<Following> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final loggedInUser = FirebaseAuth.instance.currentUser;

  int numFollowing = 0;
  String mainAvatarPath = '';
  String? username;
  List<String> following = [];
  List<String> usernames = [];

  var user = null;
  Widget profileOverviewWidgets = Container();
  List followingUserRefs = [];
  List followingUserSnaps = [];
  List numPostsForEveryUser = [];
  setUserWithID() async {
    dynamic followingDynamics = widget.userRef.data()["following"] ;
    if(followingDynamics == null)  followingDynamics = [];
    for(dynamic rf in followingDynamics)
    {
      following.add(rf.toString());
    }
    usernames = await DatabaseService().getUsernamesFromIds(following);

    user = await DatabaseService().getUserWithID(widget.userID);
    setState(() => user = user);
  }
  getFollowing(String userID) async {
    numFollowing = await DatabaseService().getNumFollowingFromID(widget.userID!);
    setState(() => numFollowing = numFollowing);
  }
  getUsername(String userID) async {
    username = await DatabaseService().getUsernameFromID(widget.userID!);
    setState(() => username = username);
  }


  setAvatarPath(){
    var userData = user.data();
    var pathDynamic = userData["avatarPath"];
    if(pathDynamic != null) mainAvatarPath = pathDynamic.toString();
  }


  buildProfileWidgets() async {
    followingUserRefs = [];
    followingUserSnaps = [];
    numPostsForEveryUser = [];

    for (String followedId in following) {
      print("should be an id:");
      print(followedId);
      var userRef = db.collection("users").doc(followedId);
      var userSnapshot = await userRef.get();
      print("printing data");
      print(userSnapshot.data());
      var followerData = userSnapshot.data();
      var postsQuery = await userRef.collection("posts").get();
      int numPosts = 0;
      if (postsQuery != null) {
        numPosts = postsQuery.docs.length;
      }

      print("should be a ref");
      followingUserRefs.add(userRef);
      print(userRef);
      print("should be a SNAPSHOT");
      followingUserSnaps.add(userSnapshot);
      print(userSnapshot);
      numPostsForEveryUser.add(numPosts);
    }
    profileOverviewWidgets = ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: numFollowing,
        itemBuilder: (context, index) {
          String followedId = following[index];
          var userRef = followingUserRefs[index];
          var userSnap = followingUserSnaps[index];
          var userData = userSnap.data();

          List<dynamic>? userFollowers = userData["followers"];
          var pathDynamic = userData["avatarPath"];
          String path = '';
          if(pathDynamic != null) path = pathDynamic.toString();

          // top

          if (userFollowers == null) userFollowers = [];
          List<String> userFollowersIds = [];

          int numPosts = numPostsForEveryUser[index];

          for (var follower in userFollowers) {
            userFollowersIds.add(follower);
          }

          int numFollowers = userFollowersIds.length;

          print("printing followers");
          print(userFollowersIds);
          // if logged in user is NOT following the searched user
          Widget buttonToDisplay; // either a follow or unfollow button
          if (userSnap.id == loggedInUser!.email) {
            buttonToDisplay = SizedBox();
          } else {
            // make button unfollow button
            print("making unfollow button");
            buttonToDisplay = ElevatedButton(
                style:
                ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                onPressed: () async {
                  await userRef.update({
                    "followers": FieldValue.arrayRemove([loggedInUser!.email])
                  });

                  // add userRef(id) to current user's following
                  var loggedInUserRef =
                  db.collection("users").doc(loggedInUser!.email);
                  await loggedInUserRef.update({
                    "following": FieldValue.arrayRemove([userRef.id])
                  });

                  // do the opposite for unfollow button

                  following.removeAt(index);
                  numFollowing -= 1;

                  await buildProfileWidgets();
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

          return ListTile(
            title: Padding(
                padding: EdgeInsets.only(
                  bottom: 5
                ),
                child: Row(
                  children: [
                    // imageWidget
                    Container(
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
                            ))),
                    SizedBox(
                        width: 5
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // show title that post is about

                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    child: Text(
                                      userData["username"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                      overflow: TextOverflow.ellipsis,
                                    ))
                              ]),
                          // button to click on to go to post view
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(right: 2),
                                    child: Text('${numFollowers} followers')),
                                Text('${numPosts} posts')
                              ])
                        ]),
                  ],
                )),
            trailing: buttonToDisplay,
          );
        });
    setState(() {});
  }

  setup() async
  {
    await setUserWithID();
    await setAvatarPath();
    buildProfileWidgets();
  }
  @override
  void initState() {
    getUsername(widget.userID!);
    getFollowing(widget.userID!);
    setup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: navBar(),
        body: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    height: 70,
                    color: Color(0xFFAF3037),
                  ),

                  SizedBox(height: 30),

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
                                          image: AssetImage(mainAvatarPath), fit: BoxFit.cover)),
                                ))),
                      ]),

                  Container(
                    child: Center(
                      child: Text(
                        username ?? "",
                        //widget.userRef.data()["username"],
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    //color: Colors.transparent,
                    //padding: EdgeInsets.all(50.0),
                    //child: Text('hi'),
                  ),

                  /*Container(
                    child: const Center(
                      child: Text('@RandomUser11',
                          style: TextStyle(
                              color: Colors.black45,
                              fontSize: 14,
                              fontWeight: FontWeight.w700)),
                    ),
                  ), */

                  const SizedBox(
                    height: 20,
                  ),
                  //Row(children: [Text(' ')]),

                  Row(children: [
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Followers(userRef: widget.userRef, userID: widget.userID!)),
                        );
                      },
                      child:Text(
                        'Followers',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Following(userRef: widget.userRef, userID: widget.userID!)),
                        );
                      },
                      child:Text(
                        'Following',
                        style: TextStyle(
                          color: Colors.transparent,
                          shadows: [
                            Shadow(offset: Offset(0, -7), color: Colors.black)
                          ],
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationThickness: 2.5,
                          decorationColor: Color(0xFFAF3037)),
                      ),
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () async {
                        List postRefs = await PostMethods().getUsersPostRefs(widget.userID);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PostsOverviewPage(postRefs: postRefs)),
                        );
                      },
                      child:Text(
                        'Posts',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Spacer()
                  ]),

                  SizedBox(
                    height: 10,
                  ),

                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: "Search for followers",
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(width: 1.4, color: Color(0xFFAF3037)),
                        ),
                      ),
                    ),
                  ),

                  Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            //"   " + widget.userRef.data()["following"].length.toString() + " Following",
                            "   " + numFollowing.toString() + " Following",
                            style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        child: FloatingActionButton.small(
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          onPressed: () {},
                          child: new Icon(
                            Icons.restart_alt,
                            color: Colors.black,
                            size: 23.00,
                          ),
                        ),
                      ),
                    ],
                  ),


                  Column(
                        children: [profileOverviewWidgets]),
                ]
            )
        )
    );
  }

  Widget CircleBlock(String nms) {
    return Container(
      child: Align(
        alignment: Alignment.center,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
              height: 80,
              width: 400,
              color: Color(0xFFEAE2B7).withOpacity(0.4),
              child: Text(nms)
          ),
        ),
      ),
    );
  }

  Widget spacing() {
    return SizedBox(
      height: 15,
    );
  }
}

