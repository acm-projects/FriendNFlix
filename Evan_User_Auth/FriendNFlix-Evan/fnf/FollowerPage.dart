import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Follower(),
    ));

class Follower extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'message',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'profile',
          ),
        ],
      ),

      /*appBar: AppBar(
        backgroundColor: Color(0xFFAF3037),
        shadowColor: Colors.transparent,
        toolbarHeight: 20,
        actions: [
          IconButton(
            icon: Icon(Icons.line_weight_sharp),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {},


          ),

        ],
      */ //),

      body: Column(
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
                  'RandomUser',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              //color: Colors.transparent,
              //padding: EdgeInsets.all(50.0),
              //child: Text('hi'),
            ),

            Container(
              child: Center(
                child: Text('@RandomUser11',
                    style: TextStyle(
                        color: Colors.black45,
                        fontSize: 14,
                        fontWeight: FontWeight.w700)),
              ),
            ),

            SizedBox(
              height: 20,
            ),
            //Row(children: [Text(' ')]),

            Row(children: [
              Spacer(),
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
              Text(
                'Following',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text(
                'Reviews',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
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
    );
  }
}
