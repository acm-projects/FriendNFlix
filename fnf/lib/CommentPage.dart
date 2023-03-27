import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: Comments(),
));

class Comments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
       // crossAxisAlignment: CrossAxisAlignment.end,
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
              child: Text("Comments",
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
          SizedBox(height: 15),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                ),
                CircleAvatar(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 28.0,
                    child: Icon(
                      Icons.person,
                      size: 30.0,
                      color: Colors.black,
                    ),
                  ),
                  backgroundColor: Color(0xFFAF3037),
                  minRadius: 30.0,
                ),

                Container(padding: EdgeInsets.all(5)),

                Text("RandomUser \nrretbyjuesdvtfvijebtuenbteerjb",
                  style: TextStyle(
                    color: Color(0xFFAF3037),
                     fontSize: 14,
                       fontWeight: FontWeight.bold
                  ),

                  ),

                Text(" 3d",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                  ),
                ),



                SizedBox(width: 10),
                //Text("frfnfw3f3"),
              ]
            ),

            SizedBox(height: 520),
            Divider( color: Color(0xFFAF3037),
              thickness: 2,),
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
                ichyon: Icon(Icons.send),
                onPressed: (){},
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
