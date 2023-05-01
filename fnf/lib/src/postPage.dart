import 'package:flutter/material.dart';
import 'package:fnf/profile/profile.dart';
import 'package:fnf/services/navBar.dart';

class PostPage extends StatefulWidget {
  PostPage({Key? key, required this.userID}) : super(key: key);
  String userID;

  @override
  State<PostPage> createState() => _postPage();
}

class _postPage extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: navBar(),

      body: SingleChildScrollView(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          SizedBox(height: 80),
          Container(
            child: Align(
              alignment: Alignment(-0.90, -1.0),
              child: IconButton(
                icon: Icon(
                Icons.arrow_back_ios,
                color: Color(0xFFAF3037),
                size: 30,
                ), onPressed: () {
                Navigator.pop(context);
              },
              ),
            ),
          ),
          Container(
            child: Center(
              child: Text("Posts",
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
      ),
    );
  }
}