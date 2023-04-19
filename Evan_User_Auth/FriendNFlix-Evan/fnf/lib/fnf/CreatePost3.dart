import 'dart:ffi';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'CreatePost4.dart';

class CreatePost3 extends StatefulWidget {
  final String filmTitle;
  final int starRating;
  final String imageURL;
  CreatePost3(
      {Key? key,
      required this.filmTitle,
      required this.starRating,
      required this.imageURL})
      : super(key: key);

  @override
  State<CreatePost3> createState() => _CreatePost3State();
}

class _CreatePost3State extends State<CreatePost3> {
  final _postBodyInputController = TextEditingController();
  Widget imageWidget = Image.asset(
    'assets/images/AlpinistExample.jpg',
    width: 375,
    height: 375,
  );

  // the forward button is disabled until the user types in the body of the post
  var _forwardButtonOnPressed;
  Color _forwardButtonColor = Colors.grey;

  void setUpImageWidget() {
    imageWidget = Image.network(widget.imageURL, width: 375, height: 375);
    setState(() {});
  }

  @override
  initState() {
    super.initState();

    _postBodyInputController.addListener(() {
      setState(() {
        print("The listener is LISTENING");
        String postBody = _postBodyInputController.text.trim();

        // disable forward button if text is not at least 10 characters
        if (postBody.isEmpty || postBody.length < 10) {
          // disable forward button and stop
          _forwardButtonColor = Colors.grey;
          _forwardButtonOnPressed = null;
          return;
        }

        // enable forward button if since the user has selected a title

        print("top");
        _forwardButtonColor = Color(0xFFAF3037);
        _forwardButtonOnPressed = () {
          print("clicked on FORWARD button");
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CreatePost4(
                    filmTitle: widget.filmTitle,
                    starRating: widget.starRating,
                    imageURL: widget.imageURL,
                    postBody: postBody)),
          );
        };
      });
    });

    setUpImageWidget();
  }

  @override
  dispose() {
    _postBodyInputController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFFF7F5),
        body: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
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
                      padding: const EdgeInsets.only(top: 20),
                      child: imageWidget),
                ),

                Row(
                  children: [
                    Text(
                      '\nADD THOUGHTS:',
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
                  ],
                ),

                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    minLines: 1,
                    maxLines: 1,
                    // obscureText: true,
                    controller: _postBodyInputController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'Type Here',
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
        ));
    // ),
    //     ],
    //   ),
    // ));
  }
}
