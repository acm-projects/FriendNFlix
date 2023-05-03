import 'dart:ffi';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

import 'CreatePost6.dart';

class CreatePost5 extends StatefulWidget {
  final String filmTitle;
  final int starRating;
  final String postBody;
  final DateTime watchDay;
  final String imageURL;
  CreatePost5(
      {Key? key,
      required this.filmTitle,
      required this.starRating,
      required this.postBody,
      required this.watchDay,
      required this.imageURL})
      : super(key: key);

  @override
  State<CreatePost5> createState() => _CreatePost5State();
}

class _CreatePost5State extends State<CreatePost5> {
  double _sliderValue = 1;
  final _phoneLevelInputController = TextEditingController();
  Widget imageWidget =
      Image.asset('assets/images/AlpinistExample.jpg', fit: BoxFit.fitHeight);

  // the forward button is disabled until the user types in the body of the post
  var _forwardButtonOnPressed;
  Color _forwardButtonColor = Colors.grey;

  void setUpImageWidget() {
    imageWidget = Image.network(widget.imageURL, fit: BoxFit.fitHeight);
    setState(() {});
  }

  void _enableForwardButton() {
    setState(() {
      print("ENABLING forward button");
      _forwardButtonColor = Colors.white;
      _forwardButtonOnPressed = () {
        print("clicked on FORWARD button");

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CreatePost6(
                  filmTitle: widget.filmTitle,
                  starRating: widget.starRating,
                  postBody: widget.postBody,
                  watchDay: widget.watchDay,
                  phoneLevel: _sliderValue.round(),
                  imageURL: widget.imageURL)),
        );
      };
    });
  }

  void _disableForwardButton() {
    setState(() {
      print("disabling forward button");
      _forwardButtonOnPressed = null;
      _forwardButtonColor = Colors.grey;
    });
  }

  @override
  initState() {
    super.initState();

    // start the text field with the same value as the starting value of the slider
    // which is 1

    _phoneLevelInputController.text = 1.toString();
    _phoneLevelInputController.addListener(() {
      setState(() {
        // check if the text in the text field is a valid phone leve (an integer
        // between 1 and 100 inclusive). If it is not, disable the forward button.
        // if it is, enable it

        String text = _phoneLevelInputController.text;

        // disable forward button if the text field is empty
        if (text.isEmpty) {
          _disableForwardButton();
          return;
        }

        // check if any non numeric characters are in the text
        int textToInt;
        // sets the int to the text in the text box or -1 if the text does not
        // represent a valid integer
        try {
          textToInt = int.parse(text);
        } catch (err) {
          textToInt = -1;
        }

        // disable the forward button if the text does not represent an int
        if (textToInt == -1) {
          _disableForwardButton();
          return;
        }

        // disable the forward button if the text is not 1-100 inclusive
        if (textToInt < 1 || textToInt > 100) {
          _disableForwardButton();
          return;
        }

        // the text is valid, enable the forward button
        _enableForwardButton();
        // set the slider to the input value
        _sliderValue = textToInt.toDouble();
      });
    });

    setUpImageWidget();
  }

  @override
  dispose() {
    _phoneLevelInputController.dispose();

    super.dispose();
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.0000000015,
                    ),
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
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          'SELECTED TITLE:',
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 018,
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
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 18,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 4,
                                      color: Colors.black,
                                    ),
                                  ],
                                ))),
                      ],
                    ),
                    Center(
                      child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Container(
                              width: 400, height: 450, child: imageWidget)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Column(
                        children: [
                          Text(
                            'ADD PHONE LEVEL:',
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              shadows: [
                                Shadow(
                                  blurRadius: 4,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 5, bottom: 5),
                              child: Slider(
                                  value: _sliderValue,
                                  onChanged: (value) {
                                    setState(() {
                                      _sliderValue = value.roundToDouble();
                                      // change the value of the text input to the value of the slider (
                                      // but cut off the .0 at the end ie instead of 1.0 show 1)
                                      _phoneLevelInputController.text =
                                          _sliderValue.toString().substring(
                                              0,
                                              _sliderValue
                                                  .toString()
                                                  .indexOf("."));

                                      // enable the forward button
                                      _enableForwardButton();
                                    });
                                  },
                                  divisions: 99,
                                  min: 1,
                                  max: 100)),
                          TextField(
                            style: TextStyle(
                                color: Colors.white
                            ),
                            controller: _phoneLevelInputController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              labelText: "Phone Level",
                              labelStyle: GoogleFonts.montserrat(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                              filled: true,
                              fillColor: Color.fromRGBO(
                                  255, 255, 255, 0.18), // 18% opacity white
                            ),
                          ),
                        ],
                      ),
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
