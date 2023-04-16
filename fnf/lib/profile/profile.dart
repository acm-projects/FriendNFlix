import 'package:flutter/material.dart';
import 'package:fnf/profile/followingPage.dart';

import '../src/postPage.dart';
import '../services/navBar.dart';
import 'followerPage.dart';

void main() => runApp(const MaterialApp(
      home: Profile(),
    ));

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const navBar(),
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  height: 70,
                  color: const Color(0xFFAF3037),
                ),
                const SizedBox(height: 30),
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
                                      builder: (context) => const Profile()),
                                );
                              },
                            ),
                          ),
                      ),
                    ]),

                Container(
                  child: const Center(
                    child: Text(
                      'RandomUser',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                //color: Colors.transparent,
                //padding: EdgeInsets.all(50.0),
                //child: Text('hi'),

                Container(
                  child: const Center(
                    child: Text('@RandomUser11',
                        style: TextStyle(
                            color: Colors.black45,
                            fontSize: 14,
                            fontWeight: FontWeight.w700)),
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
                        MaterialPageRoute(builder: (context) => Followers()),
                      );
                    },
                    child: const Text(
                      '100k',
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
                        MaterialPageRoute(builder: (context) => Following()),
                      );
                    },
                    child: const Text(
                      '300',
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
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PostPage()),
                        );
                      },
                      child:const Text(
                    '40',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )
                  ),
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
                    'Reviews',
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
                          child: const Text(
                            "Random bio stuff, tbvtoenovneotiysa",
                            style: TextStyle(
                                color: Colors.black45,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Row(children: const [Text(' ')]),

                Container(
                  child: const Align(
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
              ]),
        ));
  }
}
