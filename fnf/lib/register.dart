import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fnf/services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(home: Register() ,));
}

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: const Color(0xFFAF3037),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ListView(
                  children: <Widget>[
                    Container(
                      child: Image.asset('assets/images/logo1.png'),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'REGISTER',
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
                        //obscureText: true,
                        controller: emailController,
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
                          fillColor: Color.fromRGBO(
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
                          labelText: 'Enter Email',
                          labelStyle: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                          filled: true,
                          fillColor: Color.fromRGBO(
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
                          fillColor: Color.fromRGBO(
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
                          labelText: 'Confirm Password',
                          labelStyle: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                          filled: true,
                          fillColor: Color.fromRGBO(
                              255, 255, 255, 0.18), // 18% opacity white
                        ),
                      ),
                    ),
                    Center(
                      child: Form (
                        key: _formKey,

                      child: Transform.translate(
                        offset: Offset(
                            0, MediaQuery.of(context).size.height * 0.05),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.605,
                          height: 47,
                          child: ElevatedButton(
                            child: Text(
                              'CREATE ACCOUNT',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xFF000000),
                            ),
                            onPressed: () async {
                              /*if(_formKey.currentState.validate()) {

                              }*/
                              /*dynamic result =
                                  await _auth.registerWithEmailAndPassword(
                                      emailController.text.trim(),
                                      passwordController.text.trim());
                                   */
                              //call setUsername to be the user's username
                            },
                          ),
                        ),
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset:
                          Offset(0, MediaQuery.of(context).size.height * 0.06),
                      child: Row(
                        children: <Widget>[
                          TextButton(
                            child: const Text(
                              'ALREADY REGISTERED? LOGIN HERE',
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
                    )
                  ],
                ),
              ),
            )
    );
  }
}
