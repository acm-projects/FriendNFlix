import 'dart:ffi';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

import 'CreatePost3.dart';

class CreatePost2 extends StatefulWidget {
  final String filmTitle;
  String imageURL = "";
  CreatePost2({Key? key, required this.filmTitle, required this.imageURL})
      : super(key: key);

  @override
  State<CreatePost2> createState() => _CreatePost2State();
}

class _CreatePost2State extends State<CreatePost2> {
  var _forwardButtonOnPressed; // this will make the foward button
  Color _forwardButtonColor = Colors.grey;
  Widget imageWidget =
      Image.asset('assets/images/AlpinistExample.jpg', fit: BoxFit.fitHeight);

  // this will be an array of size 5 (one for each star) where index i coressponds
  // to the (i+1)th star. ie index 0 represents star 1. The color will be grey
  // at index 0 if star 1 is not selected, and yellow if it is
  List _starColors = [
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey
  ];

  int rating = 0;

  var _starOnPressed;

  var _starOnPressed1;
  var _starOnPressed2;
  var _starOnPressed3;
  var _starOnPressed4;
  var _starOnPressed5;

  @override
  initState() {
    super.initState();

    _starOnPressed = (int starNumber) {
      print("CLOSER");
      setState(() {
        print('clicked on star ${starNumber}');
        rating = starNumber;

        // if starNumber (the star they clicked on) is n, the first n stars
        // will change to yellow
        for (int i = 0; i < starNumber; i++) {
          _starColors[i] = Color(0xFFFAE20D);
        }

        // color the rest of the stars (the ones after the star they selected) grey
        for (int j = starNumber; j < _starColors.length; j++) {
          _starColors[j] = Colors.grey;
        }

        for (int k = 0; k < _starColors.length; k++) {
          print(_starColors[k]);
        }

        // undisable foward button if since the user has selected a starRating
        _forwardButtonColor = Colors.white;
        _forwardButtonOnPressed = () {
          print("clicked on FORWARD button");
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CreatePost3(
                    filmTitle: widget.filmTitle,
                    starRating: rating,
                    imageURL: widget.imageURL)),
          );
        };
      });
    };

    _starOnPressed1 = () {
      print("GOT HERE");
      _starOnPressed(1);
    };

    _starOnPressed2 = () {
      _starOnPressed(2);
    };

    _starOnPressed3 = () {
      _starOnPressed(3);
    };

    _starOnPressed4 = () {
      _starOnPressed(4);
    };

    _starOnPressed5 = () {
      _starOnPressed(5);
    };

    setUpImageWidget();
    // set image as one using the link of movie poster in database
  }

  void setUpImageWidget() {
    imageWidget = Image.network(widget.imageURL, fit: BoxFit.fitHeight);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFFFF7F5),
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        'assets/images/create_a_post_background2.png'),
                    //'assets/images/create_a_post_background.png'
                    fit: BoxFit.cover)),
            child: Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Center(
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

                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Text(
                          'Create a Post',
                          style: GoogleFonts.montserrat(
                            fontSize: 40,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
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
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Text(
                          'SELECTED TITLE:',
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
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
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 20,
                                shadows: [
                                  Shadow(
                                    blurRadius: 4,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Container(
                            width: 400, height: 450, child: imageWidget),
                      ),
                    ),

                    Row(
                      children: [
                        Text(
                          '\nSELECT RATINGS:',
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            shadows: [
                              Shadow(
                                blurRadius: 4,
                                color: Colors.black,
                              ),
                            ],
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: _starOnPressed1,
                          icon: Icon(
                            Icons.star,
                            color: _starColors[0],
                            size: 40,
                          ),
                        ),
                        IconButton(
                          onPressed: _starOnPressed2,
                          icon: Icon(
                            Icons.star,
                            color: _starColors[1],
                            size: 40,
                          ),
                        ),
                        IconButton(
                          onPressed: _starOnPressed3,
                          icon: Icon(
                            Icons.star,
                            color: _starColors[2],
                            size: 40,
                          ),
                        ),
                        IconButton(
                          onPressed: _starOnPressed4,
                          icon: Icon(
                            Icons.star,
                            color: _starColors[3],
                            size: 40,
                          ),
                        ),
                        IconButton(
                          onPressed: _starOnPressed5,
                          icon: Icon(
                            Icons.star,
                            color: _starColors[4],
                            size: 40,
                          ),
                        ),
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
                              color: Colors.white,
                              size: 40,
                            )),
                        IconButton(
                            onPressed: _forwardButtonOnPressed,
                            icon: Icon(
                              Icons.arrow_forward,
                              color:
                                  _forwardButtonColor, // button starts disabled
                              size: 40,
                            ))
                      ],
                    )
                  ],
                ),
              ),
            )));
    // ),
    //     ],
    //   ),
    // ));
  }
}
