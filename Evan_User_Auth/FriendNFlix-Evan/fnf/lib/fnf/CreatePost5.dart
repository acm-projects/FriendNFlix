import 'dart:ffi';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'CreatePost4.dart';
import 'CreatePost6.dart';

class CreatePost5 extends StatefulWidget {
  final String filmTitle;
  final int starRating;
  final String postBody;
  final DateTime watchDay;
  CreatePost5(
      {Key? key,
      required this.filmTitle,
      required this.starRating,
      required this.postBody,
      required this.watchDay})
      : super(key: key);

  @override
  State<CreatePost5> createState() => _CreatePost5State();
}

class _CreatePost5State extends State<CreatePost5> {
  double _sliderValue = 1;
  final _phoneLevelInputController = TextEditingController();

  // the forward button is disabled until the user types in the body of the post
  var _forwardButtonOnPressed;
  Color _forwardButtonColor = Colors.grey;

  void _enableForwardButton() {
    setState(() {
      print("ENABLING forward button");
      _forwardButtonColor = Color(0xFFAF3037);
      _forwardButtonOnPressed = () {
        print("clicked on FORWARD button");

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CreatePost6(filmTitle: widget.filmTitle, starRating: widget.starRating, postBody: widget.postBody, watchDay: widget.watchDay, phoneLevel : _sliderValue.round())),
        );
      };
    });
  }

  void _disableForwardButton(){
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
        if(text.isEmpty){
          _disableForwardButton();
          return;
        }

        // check if any non numeric characters are in the text
        int textToInt;
        // sets the int to the text in the text box or -1 if the text does not
        // represent a valid integer
        try{
          textToInt = int.parse(text);
        } catch(err){
          textToInt = -1;
        }

        // disable the forward button if the text does not represent an int
        if(textToInt == -1){
          _disableForwardButton();
          return;
        }

        // disable the forward button if the text is not 1-100 inclusive
        if(textToInt < 1 || textToInt > 100){
          _disableForwardButton();
          return;
        }


        // the text is valid, enable the forward button
        _enableForwardButton();
        // set the slider to the input value
        _sliderValue = textToInt.toDouble();
      });
    });
  }

  @override
  dispose() {
    _phoneLevelInputController.dispose();

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
                padding: const EdgeInsets.only(top: 20),
                child: Image.asset(
                  'assets/images/AlpinistExample.jpg',
                  width: 305,
                  height: 305,
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Column(
                children: [
                  Text(
                    'ADD PHONE LEVEL:',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Karla',
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
                  Slider(
                      value: _sliderValue,
                      onChanged: (value) {
                        setState(() {
                          _sliderValue = value.roundToDouble();
                          // change the value of the text input to the value of the slider (
                          // but cut off the .0 at the end ie instead of 1.0 show 1)
                          _phoneLevelInputController.text = _sliderValue.toString().
                          substring(0, 
                          _sliderValue.toString().indexOf("."));

                          // enable the forward button
                          _enableForwardButton();
                        });
                      },
                      divisions:  99,
                    min: 1,
                    max: 100
                      ),
                  TextField(
                    controller: _phoneLevelInputController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: "Phone Level",
                      labelStyle: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
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
                      color: Color(0xFFAF3037),
                      size: 30,
                    )),
                IconButton(
                    onPressed: _forwardButtonOnPressed,
                    icon: Icon(
                      Icons.arrow_forward,
                      color: _forwardButtonColor, // button starts disabled
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