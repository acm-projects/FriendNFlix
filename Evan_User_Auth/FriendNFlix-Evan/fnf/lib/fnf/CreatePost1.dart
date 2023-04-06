import 'dart:ffi';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CreatePost1 extends StatefulWidget {
  const CreatePost1({Key? key}) : super(key: key);

  @override
  State<CreatePost1> createState() => _CreatePost1State();
}

class _CreatePost1State extends State<CreatePost1> {
  TextEditingController _filmTitleInputController = TextEditingController();
  List<String> autoFillRecommendations = [];

  @override
  initState() {
    super.initState();

    _filmTitleInputController.addListener(() {
      print("jjjjjjjjjjjjjjjjjj");

      setState((){
        String userInput = _filmTitleInputController.text.trim();
        if(userInput.isEmpty) return;

        autoFillRecommendations = getAutoFillRecommendations(userInput);

        print("printing recommendations");
        for(String recommendation in autoFillRecommendations){
          print('recommendation: ${recommendation}');
        }
      });
    });
  }

  getAutoFillRecommendations(String input,
      [int maxAutoFillRecommendations = 3]) {
    print('getting matchingTitles for "${input}"');

    // get titles
    List<String> possibleTitles = [
      "attack on titan1",
      "attack on titan2",
      "attack on titan",
      "full metal alchemist",
      "blue lock",
      "demon slayer"
    ];

    // test if user input is the beginning of any titles (ie "att" is the beginning of "attack on titan")
    List<String> matchingTitles = [];
    for (String title in possibleTitles) {
      if (hasBeginningMatch(input, title)){
        print('current length of matchingTitles: ${matchingTitles.length}');
        if (matchingTitles.length <
            maxAutoFillRecommendations) // only add autofill option if there are less than 3
            {
              print('adding "${title}" to matchingTitles');
          matchingTitles.add(title);
        }
      }
      }
    return matchingTitles;
  }


  hasBeginningMatch(String shorterString, String longerString){

    // swap shorterString and longerString if shortString is longer
    if(shorterString.length > longerString.length){
      String temp = shorterString;
      shorterString = longerString;
      longerString = temp;
    }
    print('Shorter: ${shorterString}');
    print('Longer: ${longerString}');

    return longerString.startsWith(shorterString);
  }

  @override
  dispose() {
    _filmTitleInputController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7F5),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ListView(
                  children: <Widget>[
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
                          'Select a title:',
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
                          child: TextField(
                              controller: _filmTitleInputController,
                              // keyboardType: TextInputType.multiline,
                              // minLines: 1,
                              // maxLines: 3,
                              style: TextStyle(
                                fontFamily: "Karla",
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Type here',
                                hintStyle: TextStyle(
                                  fontFamily: "Karla",
                                    color: Colors.black, fontSize: 16),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 3, color: Colors.blueAccent)),
                              )),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'SELECTED:\n',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
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
                    Center(
                      child: Image.asset(
                        'assets/images/AlpinistExample.jpg',
                        width: 425,
                        height: 425,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
