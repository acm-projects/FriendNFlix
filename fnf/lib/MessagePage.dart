import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Messages(),
    ));

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          SizedBox(height: 80),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(15),
              ),
              Icon(
                Icons.arrow_back_ios,
                color: Color(0xFFAF3037),
                size: 30,
              ),
              Container(
                padding: EdgeInsets.all(9),
              ),
              CircleAvatar(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 28.0,
                  child: Icon(
                    Icons.person,
                    size: 40.0,
                    color: Colors.black,
                  ),
                ),
                backgroundColor: Color(0xFFAF3037),
                minRadius: 30.0,
              ),
              Container(padding: EdgeInsets.all(8)),
              Text(
                "\nRandomUser",
                style: TextStyle(
                    color: Color(0xFFAF3037),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Divider(
            color: Color(0xFFAF3037),
            thickness: 2,
          ),
          SizedBox(height: 15),
          SizedBox(height: 540),
          Divider(
            color: Color(0xFFAF3037),
            thickness: 2,
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(15),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              maxLines: 3,
              minLines: 1,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {},
                ),
                hintText: "Write a comment",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
