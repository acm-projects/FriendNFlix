import 'package:flutter/material.dart';
import 'package:fnf/services/navBar.dart';

import '../services/database.dart';

void main() => runApp(MaterialApp(
  theme: ThemeData.dark(),
  home: TopList(userRef: null),
));

class TopList extends StatefulWidget {

  TopList({Key? key, required this.userRef}) : super(key: key);
  dynamic userRef;
  @override
  State<TopList> createState() => _TopList();
}

class _TopList extends State<TopList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: navBar(),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            // create spacing with a sized box
            SizedBox(height: 70),
            // put arrow icon inside
            Container(
              child: Align(
                alignment: Alignment(-0.87, -1.0),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xFFAF3037),
                    size: 30,
                  ), onPressed: () {
                  Navigator.pop(context);
                },
                ),
              ),
            ),
            // create big circle, that houses a string which displays most watched movie

            SizedBox(height: 40),

            Center(
              child: Stack(
                children: <Widget>[
                  Container(
                    width: 400,
                    height: 400,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[
                          Color(0xFF7b4397),
                          Color(0xFFdc2430),
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    left: 200,
                    bottom: -0.2,
                    //Change according to your icon
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: <Color>[
                            Color(0xFFfeac5e),
                            Color(0xFFc779d0),
                            Color(0xFF4bc0c8),
                          ],
                        ),
                      ),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: <Color>[
                                  Color(0xFF649173),
                                  Color(0xFFdbd5a4),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
    );
  }
}