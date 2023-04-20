import 'package:flutter/material.dart';

import '../services/navBar.dart';

void main() => runApp(MaterialApp(
  home: Index(),
));

class Index extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        backgroundColor: Color(0xFFAF3037),
        child: Icon(Icons.add_sharp),
      ),
      bottomNavigationBar: navBar(),
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
              child: Text("Want To Watch",
                  style: TextStyle(
                      color: Color(0xFFAF3037),
                      fontSize: 25,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          //Divider(
          // color: Color(0xFFAF3037),
          // thickness: 2,
          //),
          SizedBox(height: 30),
          /*Container(
            padding: EdgeInsets.all(15.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search for followers",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.4, color: Color(0xFFAF3037)),
                ),
              ),
            ),
          */ //),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(40, 10, 12, 10),
              ),
              Container(
                height: 160,
                width: 140,
                decoration: BoxDecoration(
                  color: Color(0xFFEAE2B7),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 4,
                      offset: Offset(2, 6),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
              ),
              Container(
                height: 25,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
          SizedBox(height: 40),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(40, 10, 12, 10),
              ),
              Container(
                height: 160,
                width: 140,
                decoration: BoxDecoration(
                  color: Color(0xFFEAE2B7),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 4,
                      offset: Offset(2, 6),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
              ),
              Container(
                height: 25,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),

          SizedBox(height: 40),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(40, 10, 12, 10),
              ),
              Container(
                height: 160,
                width: 140,
                decoration: BoxDecoration(
                  color: Color(0xFFEAE2B7),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 4,
                      offset: Offset(2, 6),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
              ),
              Container(
                height: 25,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}