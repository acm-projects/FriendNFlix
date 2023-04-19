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
          currentIndex: 2,
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
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                'assets/images/logo1.png',
                                width: 95,
                                height: 95,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'FRIENDNFLIX',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF000000),
                                  fontSize: 26,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 0.0000000000000000000001),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 0.00000005), // add some space above the image
                        Image.asset(
                          'assets/images/sampleProfile.png',
                          height: 150,
                          width: 150,
                        ),
                        SizedBox(height: 0.0000000000000001), // add some space between the image and the text
                        Container(
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '@alexa_r',
                                style: TextStyle(
                                  color: Color(0xFFAF3037),
                                  fontSize: 24,
                                  fontFamily: 'Karla',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Text(
                          '     BIO:',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(width: 10), // add some spacing between the text and the curved box
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(40, 10, 10, 0),
                            child: TextField(
                              obscureText: true,
                              controller: passwordController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                labelText: 'Netflix 4eva <3',
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
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Text(
                          '    LIST:',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Montserrat',
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
                              labelText: 'Select for drop down',
                              labelStyle: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              filled: true,
                              fillColor: Color.fromRGBO(255, 255, 255, 0.18),
                            ),
                            items: [
                              DropdownMenuItem(
                                value: 'Want to Watch',
                                child: Text('Want to Watch'),
                              ),
                              DropdownMenuItem(
                                value: 'Watched',
                                child: Text('Watched'),
                              ),
                              DropdownMenuItem(
                                value: 'Posts',
                                child: Text('Posts'),
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
                      children: [
                        Text(
                          '    LIST:',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(width: 10), // add some spacing between the text and the curved box
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(40, 10, 10, 0),
                            child: TextField(
                              obscureText: true,
                              controller: passwordController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                labelText: 'Select for drop down',
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
                        ),
                      ],
                    ),





                    Row(
                      children: [
                        Text(
                          '  GENRES:',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(width: 10), // add some spacing between the text and the curved box
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(40, 10, 10, 0),
                            child: TextField(
                              obscureText: true,
                              controller: passwordController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                labelText: 'action, comedy',
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
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '    VIEW POSTS:',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(width: 10), // add some spacing between the text and the curved box
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(40, 10, 10, 0),
                            child: TextField(
                              obscureText: true,
                              controller: passwordController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                labelText: 'Select for drop down',
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
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '   BADGES:',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(width: 10), // add some spacing between the text and the curved box
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(40, 10, 10, 0),
                            child: TextField(
                              obscureText: true,
                              controller: passwordController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                labelText: 'Select for drop down',
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
                        ),
                      ],
                    ),

                    Center(
                      child: Transform.translate(
                        offset: Offset(0, MediaQuery.of(context).size.height * 0.015),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.46,
                          height: 47,
                          child: ElevatedButton(
                            child: Text(
                              'EDIT PROFILE',
                              style: TextStyle(
                                fontFamily: 'Karla',
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xFFFFC632),
                            ),
                            onPressed: () {
                              print(nameController.text);
                              print(passwordController.text);
                            },
                          ),
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