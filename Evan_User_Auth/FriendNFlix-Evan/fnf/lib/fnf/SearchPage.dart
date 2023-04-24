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
    print("matching users objects");
    print(_matchingUsers);

    for (dynamic user in _matchingUsers) {
      print("another");
      var userRef = _db.collection("users").doc(user["email"]);
      matchingUserRefs.add(userRef);
      var userSnapshot = await userRef.get();
      matchingUserSnapshots.add(userSnapshot);
    }

    print("matchingUserRefs");
    print(matchingUserRefs);

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

          if (userFollowers == null) userFollowers = [];
          List<String> userFollowersIds = [];

          for (var follower in userFollowers) {
            userFollowersIds.add(follower);
          }

          print("printing followers");
          print(userFollowersIds);
          // if logged in user is NOT following the searched user
          Widget buttonToDisplay; // either a follow or unfollow button
          if (!userFollowersIds.contains(loggedInUser!.email)) {
            print("making follow button");
            // make button follow button
            buttonToDisplay = ElevatedButton(
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
                child: Text("Follow"));
          } else {
            // make button unfollow button
            print("making unfollow button");
            buttonToDisplay = ElevatedButton(
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
                child: Text("Unfollow"));
          }

          return ListTile(
            title: Text(
              user["username"],
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            trailing: buttonToDisplay,
          );
        });
    setState(() {});
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
        appBar: AppBar(
          title: Text("Search Page"),
        ),
        body: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  onChanged: (String value) async {
                    setMatchingUsers(value);
                    _setSearchRecommendations();
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "Search for a user",
                      prefixIcon: Icon(Icons.search),
                      prefixIconColor: Colors.grey),
                ),
                Expanded(child: _searchRecommendations)
              ],
            )));
  }
}
