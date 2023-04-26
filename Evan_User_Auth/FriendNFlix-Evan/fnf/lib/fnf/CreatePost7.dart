import 'dart:ffi';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'Classes/Post.dart';
import 'CreatePost4.dart';
import 'PostMethods.dart';

class CreatePost7 extends StatefulWidget {
  final String filmTitle;
  final int starRating;
  final String postBody;
  final DateTime watchDay;
  final int phoneLevel;
  final List<String> tags;
  final String imageURL;

  CreatePost7(
      {Key? key,
      required this.filmTitle,
      required this.starRating,
      required this.postBody,
      required this.watchDay,
      required this.phoneLevel,
      required this.tags,
      required this.imageURL})
      : super(key: key);

  @override
  State<CreatePost7> createState() => _CreatePost7State();
}

class _CreatePost7State extends State<CreatePost7> {
  final users = FirebaseAuth.instance.currentUser;
  Widget imageWidget = Image.asset(
    'assets/images/AlpinistExample.jpg',
    fit: BoxFit.fitHeight
  );

  void setUpImageWidget() {
    imageWidget = Image.network(widget.imageURL, fit: BoxFit.fitHeight);
    setState(() {});
  }

  bool _clickedOnce = false;
  List<Color> _starColors = [
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey
  ];
  // the forward button is disabled until the user types in the body of the post
  void _forwardButtonOnPressed() {
    print("clicked on forward button");

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => CreatePost7(filmTitle: widget.filmTitle, starRating: widget.starRating, postBody: widget.postBody, phoneLevel : _sliderValue.round())),
    // );
  }

  Color _forwardButtonColor = Color(0xFFAF3037);

  @override
  initState() {
    super.initState();

    // change the correct stars to yellow (as opposed to grey)
    for (int i = 0; i < widget.starRating; i++) {
      _starColors[i] = Color(0xFFFAE20D);
    }

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
            padding: EdgeInsets.only(left: 10, right: 10),
            child: SingleChildScrollView(
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
                        'Post Overview',
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
                        'Selected Title:',
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
                              ))),
                    ],
                  ),
                  Center(
                    child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Container(
                          width: 225,
                          height: 225,
                          child: imageWidget
                        )),
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Rating:',
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    //color: Color(0xFFFAE20D),
                                    Icon(Icons.star,
                                        size: 30, color: _starColors[0]),
                                    Icon(Icons.star,
                                        size: 30, color: _starColors[1]),
                                    Icon(Icons.star,
                                        size: 30, color: _starColors[2]),
                                    Icon(Icons.star,
                                        size: 30, color: _starColors[3]),
                                    Icon(Icons.star,
                                        size: 30, color: _starColors[4]),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Thoughts:',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
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
                                Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10, top: 5),
                                    child:
                                    Container(
                                        height: 100,
                                        width: double.infinity,
                                        color: Colors.grey,
                                        child: SingleChildScrollView(
                                          child: Padding(
                                              padding: EdgeInsets.all(7),
                                              child: Text(widget.postBody,
                                                  style:
                                                  TextStyle(fontSize: 18))))
                                        ))
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Watch Date:',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
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
                                SizedBox(
                                    width:
                                        1), // add some spacing between the text and the curved box
                                Text(
                                    widget.watchDay.toString().substring(0, 10),
                                    style: TextStyle(fontSize: 18))
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Phone Level:',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
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
                                SizedBox(
                                    width:
                                        1), // add some spacing between the text and the curved box
                                Text(widget.phoneLevel.toString(),
                                    style: TextStyle(fontSize: 18))
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Row(
                              children: [
                                Text(
                                  'Tags:',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
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
                                SizedBox(
                                    width:
                                        1), // add some spacing between the text and the curved box
                                Text("todo")
                              ],
                            )),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 5
                          ),
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
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFFFAE20D)),
                                    onPressed: () async {
                                      // do not make a post if the button has been clicked (because
                                      // that means one is being made)
                                      if (_clickedOnce) return;

                                      _clickedOnce =
                                      true; // stop the button from making multiple posts

                                      // note: all values except the body are hard coded for right now
                                      Post newPost = Post(
                                          body: widget.postBody,
                                          filmTitle: widget.filmTitle,
                                          starRating: widget.starRating,
                                          watchDay: widget.watchDay.day,
                                          watchMonth: widget.watchDay.month,
                                          watchYear: widget.watchDay.year,
                                          phoneLevel: widget.phoneLevel,
                                          tags: widget.tags,
                                          postAuthorId: users!.email!,
                                          likedBy: [],
                                          dislikedBy: []);

                                      PostMethods postMethods = PostMethods();
                                      print("here");
                                      var result = await postMethods
                                          .addPostToFirestore(newPost);

                                      print(result);

                                      // todo what happens after post is made
                                    },
                                    child: Text('POST'))
                              ])
                        ),
                      ]),
                ]))));
  }
}