import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../services/navBar.dart';


/*
HELLO BYRON
I'm gonna assume u already had to link these pages so u could integrate them,
so I'm just gonna leave them as they are. However, i did delete the old nagivation
bar and make a class to add it in a waaaay more efficient manner. Just download
the navBar.dart file in the services folder and then return navBar() for
the bottomNagivationBar in MaterialApp just like below. That's literally the only
change I made here because it would be a waste of time when I figure you've probably
done most of it already.
*/


void main() => runApp(const CreatePost1());

class CreatePost1 extends StatelessWidget {
  const CreatePost1({Key? key}) : super(key: key);

  static const String _title = 'FriendNFlix';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        backgroundColor: const Color(0xFFFFF7F5),
        body: const MyStatefulWidget(),

        bottomNavigationBar: navBar(),

        floatingActionButton: Transform.translate(
          offset: Offset(0, -35),
          child: FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.arrow_forward, color: Color(0xFFAF3037), size: 32),
            backgroundColor: Color(0xFFFFF7F5),
            elevation: 4.0,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                          'AVAILABLE TITLES:',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Karla',
                            shadows: const [
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
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              labelText: 'Select Title',
                              labelStyle: const TextStyle(
                                fontFamily: 'Karla',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                //fontStyle: FontStyle.italic,
                                color: Colors.black,
                              ),
                              filled: true,
                              fillColor: Color.fromRGBO(255, 255, 255, 0.18),
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: 'Gilmore Girls',
                                child: Text('Gilmore Girls'),
                              ),
                              DropdownMenuItem(
                                value: 'The Night Agent',
                                child: Text('The Night Agent'),
                              ),
                              DropdownMenuItem(
                                value: 'Designated Survivor',
                                child: Text('Designated Survivor'),
                              ),
                              DropdownMenuItem(
                                value: 'Maid',
                                child: Text('Maid'),
                              ),
                            ],
                            onChanged: (value) {
                              // Handle dropdown value changes here
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: const [
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