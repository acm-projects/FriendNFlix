import 'package:flutter/material.dart';
import 'package:fnf/profile/followingPage.dart';
import 'package:fnf/profile/profile.dart';

import '../src/postPage.dart';
import '../services/navBar.dart';

void main() => runApp(MaterialApp(
  home: Followers(),
));

class Followers extends StatelessWidget {
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
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              //color: Colors.transparent,
              //padding: EdgeInsets.all(50.0),
              //child: Text('hi'),
            ),

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
              const Spacer(),
              Text(
                'Followers',
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
              Spacer(),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Following()),
                    );
                  },
                  child:Text(
                'Following',
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
                      MaterialPageRoute(builder: (context) => PostPage()),
                    );
                  },
                  child:Text(
                'Reviews',
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
                      "      300 Followers",
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
            children: <Widget> [
            Container(
              child: Align(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 80,
                    width: 400,
                    color: Color(0xFFEAE2B7).withOpacity(0.4),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 15,
            ),

            Container(
              child: Align(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 80,
                    width: 400,
                    color: Color(0xFFEAE2B7).withOpacity(0.4),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 15,
            ),

            Container(
              child: Align(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 80,
                    width: 400,
                    color: Color(0xFFEAE2B7).withOpacity(0.4),
                  ),
                ),
              ),
            ),
              SizedBox(
                height: 15,
              ),

              Container(
                child: Align(
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 80,
                      width: 400,
                      color: Color(0xFFEAE2B7).withOpacity(0.4),
                    ),
                  ),
                ),
              ),
          ]),
          ),
        ]
      )
      )
    );
  }
}