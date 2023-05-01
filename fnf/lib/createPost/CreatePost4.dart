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
  final String imageURL;
  CreatePost4(
      {Key? key,
        required this.filmTitle,
        required this.starRating,
        required this.postBody,
        required this.imageURL})
      : super(key: key);

  @override
  State<CreatePost4> createState() => _CreatePost4State();
}

class _CreatePost4State extends State<CreatePost4> {
  DateTime _watchDay = DateTime.now();
  String _watchDayString = DateTime.now().toString().substring(0, 10);
  Widget imageWidget = Image.asset(
    'assets/images/AlpinistExample.jpg',
    fit: BoxFit.fitHeight,
  );

  Color _forwardButtonColor = Color(0xFFAF3037);
  void _forwardButtonOnPressed() {
    print("clicked on FORWARD button");
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CreatePost5(
              filmTitle: widget.filmTitle,
              starRating: widget.starRating,
              imageURL: widget.imageURL,
              postBody: widget.postBody,
              watchDay: _watchDay)),
    );
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: Color(0xFFAF3037),
                onPrimary: Colors.white,
                onSurface: Colors.black,
              ),
              textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.pinkAccent,
                  ))),
          child: child!,
        );
      },
    ).then((value) {
      if (value == null) return;
      _watchDay = value;
      _watchDayString = _watchDay.toString().substring(0, 10);
      setState(() {});
    });
  }

  void setUpImageWidget() {
    imageWidget = Image.network(widget.imageURL, fit: BoxFit.fitHeight);
    setState(() {});
  }

  @override
  initState() {
    super.initState();

    setUpImageWidget();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFFF7F5),
        body: Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: SingleChildScrollView(
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
                        fontSize: 18,
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
                    Expanded(
                      child: Text(widget.filmTitle,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'Karla',
                            shadows: [
                              Shadow(
                                blurRadius: 4,
                                color: Colors.black,
                              ),
                            ],
                          )),
                    ),
                  ],
                ),

                Center(
                  child: Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Container(
                          width: 375,
                          height: 375,
                          child: imageWidget
                      )),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        child: Text(
                          "Change watch date",
                          style: TextStyle(fontSize: 18),
                        ),
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
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            height: 2,
                            fontSize: 20))
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(top: 25),
                    child: Row(
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
                            onPressed: _forwardButtonOnPressed,
                            icon: Icon(
                              Icons.arrow_forward,
                              color:
                              _forwardButtonColor, // button starts disabled
                              size: 30,
                            ))
                      ],
                    ))
              ],
            ),
          ),
        ));
    // ),
    //     ],
    //   ),
    // ));
  }
}