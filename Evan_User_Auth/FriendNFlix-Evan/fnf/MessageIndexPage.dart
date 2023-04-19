import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Index(),
    ));

class Index extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'message',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'profile',
          ),
        ],
      ),
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
              child: Text("Messages",
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
          SizedBox(height: 10),
          Container(
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
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "      300 Results",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
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
        ],
      ),
    );
  }
}
