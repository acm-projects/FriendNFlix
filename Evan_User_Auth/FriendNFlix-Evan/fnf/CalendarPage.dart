import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Calender(),
    ));

class Calender extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          SizedBox(height: 80),

          Container(
            child: Align(
                alignment: Alignment(-0.90, -1.0),

                 child: Icon(
                   Icons.arrow_back_ios,
                   color: Color(0xFFAF3037),
                   size: 30,
                 ),
            ),
          ),
          Container(
            child: Center(
              child: Text("Calendar",
                  style: TextStyle(
                      color: Color(0xFFAF3037),
                      fontSize: 25,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          Divider(
            color: Color(0xFFAF3037),
            thickness: 2,
          ),
          SizedBox(height: 380),
          Container(
            child: Align(
              alignment: Alignment(-0.85, 0.0),
              child: Text("Events",
                  style: TextStyle(
                      color: Color(0xFFAF3037),
                      fontSize: 21,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          Divider(
            color: Color(0xFFAF3037),
            thickness: 2,
          ),
          SizedBox(height: 35),
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
          SizedBox(height: 30),
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
        ],
      ),
    );
  }
}
