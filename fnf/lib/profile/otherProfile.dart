import 'package:flutter/material.dart';
import 'package:fnf/services/database.dart';

import '../services/navBar.dart' as navBar;
import '../src/postPage.dart';
import 'followerPage.dart';
import 'followingPage.dart';

class otherProfile extends StatefulWidget {
  otherProfile({Key? key, required this.userID}) : super(key: key);
  String userID;

  @override
  State<otherProfile> createState() => _otherProfileState();
}

class _otherProfileState extends State<otherProfile> {
  Widget profileWidget = Container();
  dynamic user = null;
  setUserWithID(String userID) async {
    user = await DatabaseService().getUserWithID(widget.userID);
  }

  buildProfileWidget() async {
    dynamic data = user.data();

    profileWidget = Scaffold(
        floatingActionButton: FloatingActionButton.large(
          elevation: 0,
          backgroundColor: Color(0xFFAF3037),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          child: const Text(
            "Follow",
            style: TextStyle(
                color: Colors.white, fontSize: 17, fontWeight: FontWeight.w700),
          ),
          onPressed: () {},
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
                    children: const <Widget>[
                      CircleAvatar(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 68.0,
                          child: Icon(
                            Icons.person,
                            size: 100.0,
                            color: Colors.black,
                          ),
                        ),
                        backgroundColor: Color(0xFFAF3037),
                        minRadius: 70.0,
                      ),
                    ]),

                Container(
                  child: Center(
                    child: Text(
                      data["username"],
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),
                Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color(0xFFEAE2B7).withOpacity(0),
                                // Color(0xFFEAE2B7).withOpacity(0.4),
                                elevation: 0.0,
                                shadowColor: Colors.transparent,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Followers(userRef: user, userID: widget.userID)),
                                );
                              },
                              child: Column(children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                ),
                                Text(
                                  data["followers"].length.toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  ' Followers',
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700),
                                ),
                              ])),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Following(userRef: user, userID: widget.userID)),
                            );


                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color(0xFFEAE2B7).withOpacity(0),
                                // Color(0xFFEAE2B7).withOpacity(0.4),
                                elevation: 0.0,
                                shadowColor: Colors.transparent,
                              ),
                              child: Column(children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                ),
                                Text(
                                  data["following"].length.toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Following',
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700),
                                ),
                              ])),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color(0xFFEAE2B7).withOpacity(0),
                                // Color(0xFFEAE2B7).withOpacity(0.4),
                                elevation: 0.0,
                                shadowColor: Colors.transparent,
                              ),
                              onPressed: () {
                                print("clicked posts");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PostPage(userID: "please@gmail.com")),
                                );
                              },
                              child: Column(children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                ),
                                Text(
                                  "500K",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Posts',
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700),
                                ),
                              ])),
                        ])),
                Container(
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        height: 100,
                        width: 370,
                        color: Color(0xFFEAE2B7).withOpacity(0.4),
                      ),
                    ),
                  ),
                ),

                Row(children: [Text(' ')]),

                Container(
                  child: Align(
                    alignment: Alignment(-0.75, 0.0),
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

                Row(children: [Text(' ')]),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 90,
                      width: 90,
                      color: Color(0xFFEAE2B7).withOpacity(0.4),
                    ),
                    Container(
                      height: 90,
                      width: 90,
                      color: Color(0xFFEAE2B7).withOpacity(0.4),
                    ),
                    Container(
                      height: 90,
                      width: 90,
                      color: Color(0xFFEAE2B7).withOpacity(0.4),
                    ),
                  ],
                ),

                Row(children: [Text(' ')]),

                Container(
                  child: Align(
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

                Row(children: [Text(' ')]),

                Container(
                  child: Align(
                    alignment: Alignment(-0.35, 0.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(45),
                      child: Container(
                        height: 40,
                        width: 325,
                        color: Color(0xFFEAE2B7).withOpacity(0.4),
                      ),
                    ),
                  ),
                ),

                Row(children: [Text(' ')]),

                Container(
                  child: Align(
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

                Row(children: [Text(' ')]),

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
              ]),
        ));
    setState(() {});
  }

  void setUserProfile() async {
    await setUserWithID(widget.userID);
    buildProfileWidget();
  }

  @override
  void initState() {
    setUserProfile();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return profileWidget;
  }
}
