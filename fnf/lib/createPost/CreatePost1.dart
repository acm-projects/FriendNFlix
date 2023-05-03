import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


import 'package:google_fonts/google_fonts.dart';
import 'CreatePost2.dart';

class CreatePost1 extends StatefulWidget {
  const CreatePost1({Key? key}) : super(key: key);

  @override
  State<CreatePost1> createState() => _CreatePost1State();
}

class _CreatePost1State extends State<CreatePost1> {
  List<String> autoFillRecommendations = [];
  List<String> possibleTitles = [];
  Map<String, String> posterLinks = {};
  String selectedTitle = "";
  Widget imageWidget = Center(
    child:
  Container(
      padding: EdgeInsets.all(0.0),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Color(0xFFAF3037), width: 2)),
      child: IconButton(
          padding: EdgeInsets.all(3),
          constraints: BoxConstraints(),
          iconSize: 400,
          onPressed: (){},
          icon: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage('assets/images/logo1.png'), fit: BoxFit.cover)),
          ))));

  var _forwardButtonOnPressed; // this will make the foward button
  Color _forwardButtonColor = Colors.grey;  // button starts disabled until user type in the title
  // disabled until told other wise

  void _enableForwardButton() {
    setState(() {
      _forwardButtonColor = Colors.white;
      _forwardButtonOnPressed = () {

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CreatePost2(filmTitle: selectedTitle, imageURL: posterLinks[selectedTitle]!,)),
        );
      };
    });
  }

  void _disableForwardButton(){
    setState(() {
      _forwardButtonOnPressed = null;
      _forwardButtonColor = Colors.grey;
    });
  }


  @override
  initState() {
    super.initState();
    _setPossibleTitles();

  }

  void _setPossibleTitles() async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;

    // get titles

    var moviesQuerySnapshot = await _db.collection("movies").get();

    for (var movieSnapshot in moviesQuerySnapshot.docs) {
      Map<String, dynamic> movieData = movieSnapshot.data();
      possibleTitles.add('${movieData["title"]}');
      posterLinks[movieData["title"]] = movieData["posterLink"];
    }
  }

  getAutoFillRecommendations(String input,
      [int maxAutoFillRecommendations = 3]) async {

    // test if user input is the beginning of any titles (ie "att" is the beginning of "attack on titan")
    List<String> matchingTitles = [];
    for (String title in possibleTitles) {
      if (hasBeginningMatch(input, title)) {
        if (matchingTitles.length <
            maxAutoFillRecommendations) // only add autofill option if there are less than 3
            {
          matchingTitles.add(title);
        }
        else break;
      }
    }
    return matchingTitles;
  }

  hasBeginningMatch(String shorterString, String longerString) {
    // swap shorterString and longerString if shortString is longer
    if (shorterString.length > longerString.length) {
      String temp = shorterString;
      shorterString = longerString;
      longerString = temp;
    }

    // ignore casing when deciding if strings match
    return longerString.toLowerCase().contains(shorterString.toLowerCase());
  }

  bool matchesAnyTitle(String text) {
    for(String film in possibleTitles){
      if(text.toLowerCase() == film.toLowerCase())
        return true;
    }
    return false;
  }

  @override
  dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFFFF7F5),
        body:
        /*Padding(
          padding: EdgeInsets.only(
              left: 15,
              right: 15
          ), */


        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/create_a_post_background2.png'),
              //'assets/images/create_a_post_background.png'
              fit: BoxFit.cover
            )
          ),
          child: Center(
            child:
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // Expanded(
                  //   child: Center(
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(10),
                  //       child: ListView(
                  //         children: <Widget>[

                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 40,
                          bottom: 10
                      ),
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
                  Padding(
                      padding: EdgeInsets.only(
                          bottom: 10
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Select a title:',
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
                              child:
                              Autocomplete<String>(
                                fieldViewBuilder: (BuildContext context,
                                    TextEditingController fieldTextEditingController,
                                    FocusNode fieldFocusNode,
                                    VoidCallback onFieldSubmitted){
                                  return TextField(
                                    controller: fieldTextEditingController,
                                    focusNode: fieldFocusNode,
                                    style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),

                                  );
                                },
                                optionsBuilder: (TextEditingValue textEditingValue) async{
                                  String text = textEditingValue.text.trim();

                                  if(matchesAnyTitle(text)){
                                    _enableForwardButton();
                                    selectedTitle = text;
                                  }
                                  else _disableForwardButton();

                                  return await getAutoFillRecommendations(text);
                                },
                                onSelected: (String option){
                                  _enableForwardButton();
                                  selectedTitle = option;
                                  imageWidget =
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 20),
                                          child: Container(
                                              width: 400,
                                              height: 450,
                                              child: Image.network(posterLinks[selectedTitle]!, fit: BoxFit.fitHeight,)
                                          ),
                                        ),
                                      );
                                  setState(() {

                                  });
                                },)
                          ),
                        ],
                      )
                  ),
                  Row(
                    children: [
                      Text(
                        'SELECTED:\n',
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
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
                  SizedBox(
                    height: 5,
                  ),
                  imageWidget,
                  SizedBox(
                    height: 40,
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
                            color: _forwardButtonColor, // button starts disabled
                            size: 40,
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),)
    ,
    );
  }
}