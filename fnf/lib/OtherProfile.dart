import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Home(),
    ));

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  'Rando2',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              //color: Colors.transparent,
              //padding: EdgeInsets.all(50.0),
              //child: Text('hi'),
            ),

            Container(
              child: Center(
                child: Text('@littleManTest',
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
              //Spacer(),
              Padding(
                padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
              ),
              Text(
                '10',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              //Spacer(),
              Padding(
                padding: EdgeInsets.fromLTRB(46, 10, 45, 10),
              ),
              Text(
                ' 200',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              //Spacer(),
              Padding(
                padding: EdgeInsets.fromLTRB(35, 10, 55, 10),
              ),
              Text(
                '5k',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Spacer()
            ]),
            //),

            Row(children: [
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

            Row(children: [Text(' ')]),

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

            /* Container(
           child: Align(
             alignment: Alignment(-0.75, 0.0),
             child: ClipRRect(
               borderRadius: BorderRadius.circular(30),
               child: Container(
                 height: 90,
                 width: 90,
                 color: Color(0xFFEAE2B7).withOpacity(0.4),
                 child: Container(
                   ),
                 ),
               ),
             ),
          */ //),
          ]),
    );
  }
}
