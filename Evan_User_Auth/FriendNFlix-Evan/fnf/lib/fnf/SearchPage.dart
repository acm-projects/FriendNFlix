import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fnf/fnf/PostMethods.dart';
import 'package:fnf/fnf/posts_index.dart';
import 'package:fnf/fnf/printMap.dart';

import 'Classes/Post.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final loggedInUser = FirebaseAuth.instance.currentUser;

  Widget _searchRecommendations = Container();
  List _allUsers = [];
  List _matchingUsers = [];

  _setSearchRecommendations() async {
    List matchingUserRefs = [];
    List matchingUserSnapshots = [];
    List<int> numPostsForEveryUser = [];
    print("matching users objects");
    print(_matchingUsers);


    for (dynamic user in _matchingUsers) {
      print("another");
      var userRef = _db.collection("users").doc(user["email"]);
      print("USER OBJECT");
      print(user);
      print("USER REFERENCE");
      print(userRef);
      matchingUserRefs.add(userRef);
      var userSnapshot = await userRef.get();
      matchingUserSnapshots.add(userSnapshot);
      var postQuerySnapshot = await userRef.collection("posts").get();
      if (postQuerySnapshot == null || postQuerySnapshot.docs == null) {
        numPostsForEveryUser.add(0);
      } else
        numPostsForEveryUser.add(postQuerySnapshot.docs.length);
    }

    print("matchingUserRefs");
    print(matchingUserRefs);

    if(_matchingUsers.length == 0) {
      _searchRecommendations = ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index){
            return ListTile(title: Padding(
              padding: EdgeInsets.only(
              ),
              child: Center(
                child: Text("0 results",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black
                ),)
              )
            ),);

          });
      return;
    }
    _searchRecommendations = ListView.builder(
        itemCount: _matchingUsers.length,
        itemBuilder: (context, index) {
          print("pay attention to me");
          dynamic user = _matchingUsers[index];
          print(user);
          var userRef = matchingUserRefs[index];
          print(userRef);
          var userSnap = matchingUserSnapshots[index];
          var userData = userSnap.data();
          print(userData);

          List<dynamic>? userFollowers = userData["followers"];

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
                    }
          else if (!userFollowersIds.contains(loggedInUser!.email)) {
            print("making follow button");
            // make button follow button
            buttonToDisplay = ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreenAccent),
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

                  await _setSearchRecommendations();
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
                    ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
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

                  await _setSearchRecommendations();
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

          return ListTile(
            title: Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  children: [
                    // imageWidget
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // show title that post is about

                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    child: Text(
                                  user["username"],
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
                                  padding: EdgeInsets.only(
                                    right: 2
                                  ),
                                  child: Text('${numFollowers} followers')
                                ),
                                Text('${numPosts} posts')
                              ])
                        ]),
                  ],
                )),
            trailing: buttonToDisplay,
          );
        });

    setState(() {
      print("printing search recommendations");
      print(_searchRecommendations);
    });
  }

  hasBeginningMatch(String shorterString, String longerString) {
    // swap shorterString and longerString if shortString is longer
    if (shorterString.length > longerString.length) {
      String temp = shorterString;
      shorterString = longerString;
      longerString = temp;
    }

    // ignore casing when deciding if strings match
    return longerString.toLowerCase().contains(shorterString.toLowerCase());
  }

  void setMatchingUsers(String value) {
    print("got here!");
    _matchingUsers = [];
    if (value.isEmpty) return;

    print(_allUsers);
    for (dynamic user in _allUsers) {
      print("giggity");
      if (user["username"] == null) continue;

      if (hasBeginningMatch(user["username"], value)) {
        print('I believe ${user["username"]} matches ${value}');
        _matchingUsers.add(user);
      }

      setState(() {});
    }
  }

  void setAllUsers() async {
    var allUsersQuery = await _db.collection("users").get();
    for (var userRef in allUsersQuery.docs) {
      _allUsers.add(userRef.data());
    }

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    setAllUsers();
  }

  void updateList(String value) {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.only(
              top: 45,
              left: 15,
              right: 15,
              bottom: 15
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  onChanged: (String value) async {
                    setMatchingUsers(value);
                    _setSearchRecommendations();
                  },
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18
                  ),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Color(0xFFAF3037))
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Color(0xFFAF3037))
                    ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "Search for a user",
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18
                      ),
                      prefixIcon: Icon(Icons.search,
                      size: 25,
                      color: Colors.red,),
                      prefixIconColor: Colors.grey),
                ),
                Expanded(child: _searchRecommendations)
              ],
            )));
  }
}