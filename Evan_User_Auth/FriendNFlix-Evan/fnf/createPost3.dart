import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'FriendNFlix';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        backgroundColor: const Color(0xFFFFF7F5),
        body: const MyStatefulWidget(),

        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          currentIndex: 1,
          iconSize: 40,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Create Post',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
        floatingActionButton: Stack(
          children: [
            Positioned(
              bottom: 75,
              left: 53,
              child: FloatingActionButton(
                onPressed: () {},
                child: Icon(Icons.arrow_back, color: Color(0xFFAF3037), size: 32),
                backgroundColor: Color(0xFFFFF7F5),
                elevation: 4.0,
              ),
            ),
            Positioned(
              bottom: 75,
              right: 20,
              child: FloatingActionButton(
                onPressed: () {},
                child: Icon(Icons.arrow_forward, color: Color(0xFFAF3037), size: 32),
                backgroundColor: Color(0xFFFFF7F5),
                elevation: 4.0,
              ),
            ),
          ],
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
                            items: [
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
                        obscureText: true,
                        controller: passwordController,
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