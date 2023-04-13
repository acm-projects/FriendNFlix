import 'dart:ffi';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'CreatePost5.dart';

class CreatePost4 extends StatefulWidget {
  final String filmTitle;
  final int starRating;
  final String postBody;
  CreatePost4(
      {Key? key,
      required this.filmTitle,
      required this.starRating,
      required this.postBody})
      : super(key: key);

  @override
  State<CreatePost4> createState() => _CreatePost4State();
}

class _CreatePost4State extends State<CreatePost4> {
  DateTime _watchDay = DateTime.now();
  String _watchDayString = DateTime.now().toString().substring(0, 10);

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2010),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) return;
      _watchDay = value;
      _watchDayString = _watchDay.toString().substring(0, 10);
      setState(() {

      });
    });
  }

  @override
  initState() {
    super.initState();

  }

  @override
  dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7F5),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            // Expanded(
            //   child: Center(
            //     child: Padding(
            //       padding: const EdgeInsets.all(10),
            //       child: ListView(
            //         children: <Widget>[

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.0000000015,
            ),

            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Text(
                  'Create a Post',
                  style: TextStyle(
                    fontFamily: 'Karla',
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFAF3037),
                    shadows: [
                      Shadow(
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.5),
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Row(
              children: [
                Text(
                  'SELECTED TITLE:',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Karla',
                    shadows: [
                      Shadow(
                        blurRadius: 4,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(width: 10),
                Text(widget.filmTitle,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Karla',
                      shadows: [
                        Shadow(
                          blurRadius: 4,
                          color: Colors.black,
                        ),
                      ],
                    ))
              ],
            ),

            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Image.asset(
                  'assets/images/AlpinistExample.jpg',
                  width: 305,
                  height: 305,
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    child: Text("Change watch date"),
                    onPressed: _showDatePicker,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFAF3037))
                    //   color: Colors.black,
                    //   fontSize: 16,
                    //   fontFamily: 'Karla',
                    //   fontWeight: FontWeight.w700,
                    //   shadows: [
                    //   Shadow(
                    //   blurRadius: 4,
                    //   color: Colors.black,
                    // ),)
                    ),
                SizedBox(
                    width:
                        1), // add some spacing between the text and the curved box
                Text(_watchDayString,
                    style: TextStyle(backgroundColor: Colors.grey))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Color(0xFFAF3037),
                      size: 30,
                    )),
                IconButton(
                    onPressed: () {
                      print("clicked forward button");

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CreatePost5(filmTitle: widget.filmTitle, starRating: widget.starRating, postBody: widget.postBody, watchDay: _watchDay)),
                      );
                    },
                    icon: Icon(
                      Icons.arrow_forward,
                      color: Color(0xFFAF3037), // button starts disabled
                      size: 30,
                    ))
              ],
            )
          ],
        ),
      ),
    );
    // ),
    //     ],
    //   ),
    // ));
  }
}
