import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      theme: ThemeData.dark(),
      home: TopList(),
    ));

class TopList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'message',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'profile',
          ),
        ],
      ),
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
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xFFAF3037),
                  size: 35,
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

                  /*Container(
                      width: 100,
                      height: 100,
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
                    */ //),
                ],
              ),

              /*8Stack(
              children: <Widget>[
                Container(
                  width: 200,
                  height: 200,
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

              ],
            */ //),
            ),
          ]),
    );
  }
}
