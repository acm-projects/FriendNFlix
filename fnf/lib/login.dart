import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: MyStatefulWidget()));

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
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/logo_background2.png'),
                  fit: BoxFit.cover),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height *
                          0.02, // move everything down by 20%
                    ),

                    Container(
                      width: 320, // set width
                      height: 320,
                      child: Image.asset('assets/images/logo1.png'),
                    ),

                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(10, 1, 10, 10),
                      //padding: const EdgeInsets.all(10),
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                            color: Colors.white),
                      ),
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
                          labelText: 'Enter Username',
                          labelStyle: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                          filled: true,
                          fillColor: const Color.fromRGBO(
                              255, 255, 255, 0.18), // 18% opacity white
                        ),
                      ),
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
                          labelText: 'Enter Password',
                          labelStyle: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                          filled: true,
                          fillColor: const Color.fromRGBO(
                              255, 255, 255, 0.18), // 18% opacity white
                        ),
                      ),
                    ),

                    // get rid of from center to where the E in elevated button is and same for the
                    // next one

                    Center(
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.27,
                          height: 47,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xFF000000),
                            ),
                            onPressed: () {
                              print(nameController.text);
                              print(passwordController.text);
                            },
                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ), //add comm

                    
                    Row(
                        children: <Widget>[
                          TextButton(
                            child: const Text(
                              'NEW ACCOUNT? REGISTER HERE',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic),
                            ),
                            onPressed: () {
                              //signup screen
                            },
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                  ],
                ),
              ),
            )));
  }
}
