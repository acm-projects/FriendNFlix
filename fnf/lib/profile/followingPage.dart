import 'package:flutter/material.dart';
import 'package:fnf/profile/profile.dart';
import 'package:fnf/services/database.dart';

import '../src/postPage.dart';
import '../services/navBar.dart';
import 'followerPage.dart';

class Following extends StatefulWidget {

  Following({Key? key, required this.userRef, required this.userID}) : super(key: key);
  dynamic userRef;
  String? userID;
  @override
  State<Following> createState() => _FollowingState();
}

class _FollowingState extends State<Following> {
  int numFollowing = 0;
  String? username;
  List<String> following = [];
  List<String> usernames = [];
  List<Widget> profileOverviewWidget = [];
  setUserWithID() async {
    for(dynamic rf in widget.userRef.data()["following"])
    {
      following.add(rf.toString());
    }
    usernames = await DatabaseService().getUsernamesFromIds(following);
  }
  getFollowing(String userID) async {
    numFollowing = await DatabaseService().getNumFollowingFromID(widget.userID!);
    setState(() => numFollowing = numFollowing);
  }
  getUsername(String userID) async {
    username = await DatabaseService().getUsernameFromID(widget.userID!);
    setState(() => username = username);
  }

  buildProfileWidgets()
  {
    profileOverviewWidget = [];
    for(String usrnmes in following)
    {
      print(usrnmes);
      profileOverviewWidget.add(CircleBlock(usrnmes));
    }
    setState(() {
    });
  }

  setup() async
  {
    await setUserWithID();
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
                                      builder: (context) => Profile(userID: widget.userRef!.data()["email"])),
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
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PostPage(userID: 'please@gmail.com',)),
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
                            numFollowing.toString(),
                            style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
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

                  SizedBox(
                    height: 15,
                  ),
                  SingleChildScrollView(
                    child: Column(
                        children: profileOverviewWidget),
                  ),
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

