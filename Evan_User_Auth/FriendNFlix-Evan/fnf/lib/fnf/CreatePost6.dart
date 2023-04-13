import 'dart:ffi';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'CreatePost4.dart';
import 'CreatePost7.dart';

class CreatePost6 extends StatefulWidget {
  final String filmTitle;
  final int starRating;
  final String postBody;
  final DateTime watchDay;
  final int phoneLevel;
  CreatePost6(
      {Key? key,
        required this.filmTitle,
        required this.starRating,
        required this.postBody,
        required this.watchDay,
        required this.phoneLevel
      })
      : super(key: key);

  @override
  State<CreatePost6> createState() => _CreatePost6State();
}

class _CreatePost6State extends State<CreatePost6> {
  final _tagInputController = TextEditingController();

  // the forward button is disabled until the user types in the body of the post
  void _forwardButtonOnPressed (){
    print("clicked on forward button");

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreatePost7(filmTitle: widget.filmTitle, starRating: widget.starRating, postBody: widget.postBody, phoneLevel : widget.phoneLevel, tags: _tags, watchDay: widget.watchDay,)),
    );

  }

  Color _forwardButtonColor = Color(0xFFAF3037);
  List<String> _tags = [];
  String _tagsString = "";


  @override
  initState() {
    super.initState();
    _tagInputController.addListener(() {

    });
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
              height: MediaQuery.of(context).size.height *
                  0.0000000015,
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
              child: Row(
                  children: [
                    Text(
                      'CURRENT TAGS: ',
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
                  ]
              ),
            ),

            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Text(
                _tagsString,
                style: null,
              ),
            ),

            Row(
              children: [
                Text(
                  '\nADD TAGS:',
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
                controller: _tagInputController,
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
                  fillColor: Color.fromRGBO(255, 255, 255, 0.18), // 18% opacity white
                ),
              ),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState((){
                    print("Clicked submit tag button!");
                    String tag = _tagInputController.text.trim();
                    _tagInputController.text = "";

                    // validate string to see if tag is valid

                    // tag cannot be an empty string
                    if(tag.isEmpty){
                    return;
                    }

                    // do not add tag if the same tag is already there
                    if(_tags.contains(tag)){
                      return;
                    }

                    // todo write more validations

                    _tags.add(tag);

                    if(_tagsString.isEmpty){
                      _tagsString = "#" + tag;
                    } else {
                      _tagsString = _tagsString + ", #" + tag;
                    }


                    });

                  },
                  child: Text("Submit tag"),
                ),
              ]
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
