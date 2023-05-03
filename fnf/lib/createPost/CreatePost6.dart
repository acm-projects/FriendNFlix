import 'dart:ffi';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

import 'CreatePost4.dart';
import 'CreatePost7.dart';

class CreatePost6 extends StatefulWidget {
  final String filmTitle;
  final int starRating;
  final String postBody;
  final DateTime watchDay;
  final int phoneLevel;
  final String imageURL;
  CreatePost6(
      {Key? key,
      required this.filmTitle,
      required this.starRating,
      required this.postBody,
      required this.watchDay,
      required this.phoneLevel,
      required this.imageURL})
      : super(key: key);

  @override
  State<CreatePost6> createState() => _CreatePost6State();
}

class _CreatePost6State extends State<CreatePost6> {
  final _tagInputController = TextEditingController();
  Widget imageWidget =
      Image.asset('assets/images/AlpinistExample.jpg', fit: BoxFit.fitHeight);

  // the forward button is disabled until the user types in the body of the post
  void _forwardButtonOnPressed() {
    print("clicked on forward button");

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CreatePost7(
              filmTitle: widget.filmTitle,
              starRating: widget.starRating,
              postBody: widget.postBody,
              phoneLevel: widget.phoneLevel,
              tags: _tags,
              watchDay: widget.watchDay,
              imageURL: widget.imageURL)),
    );
  }

  Color _forwardButtonColor = Colors.white;
  List<String> _tags = [];
  String _tagsString = "";

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
    _tagInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFFF7F5),
        body: Stack(children: <Widget>[
          Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          'assets/images/create_a_post_background2.png'),
                      //'assets/images/create_a_post_background.png'
                      fit: BoxFit.cover))),
          SingleChildScrollView(
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
                          fontSize: 16,
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
                              )))
                    ],
                  ),

                  Center(
                    child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Container(
                            width: 400, height: 400, child: imageWidget)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                    child: Row(children: [
                      Text(
                        'CURRENT TAGS: ',
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 16,
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
                      Text(
                        _tagsString,
                        style: GoogleFonts.montserrat(
                            fontSize: 18, color: Colors.white),
                      ),
                    ]),
                  ),

                  Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: [
                          Text(
                            'ADD TAGS:',
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 16,
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
                      )),

                  Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        controller: _tagInputController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: 'Type Here',
                          labelStyle: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                          filled: true,
                          fillColor: Color.fromRGBO(
                              255, 255, 255, 0.18), // 18% opacity white
                        ),
                      )),

                  Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFAF3037)),
                        onPressed: () {
                          setState(() {
                            print("Clicked submit tag button!");
                            String tag = _tagInputController.text.trim();
                            _tagInputController.text = "";

                            // validate string to see if tag is valid

                            // tag cannot be an empty string
                            if (tag.isEmpty) {
                              return;
                            }

                            // do not add tag if the same tag is already there
                            if (_tags.contains(tag)) {
                              return;
                            }

                            // todo write more validations

                            _tags.add(tag);

                            if (_tagsString.isEmpty) {
                              _tagsString = "#" + tag;
                            } else {
                              _tagsString = _tagsString + ", #" + tag;
                            }
                          });
                        },
                        child: Text(
                          "Submit tag",
                          style: GoogleFonts.montserrat(fontSize: 18),
                        ),
                      )),

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
          ))
        ]));
    // ),
    //     ],
    //   ),
    // ));
  }
}
