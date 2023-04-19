import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fnf/src/login.dart';
import 'package:fnf/services/auth.dart';
import 'package:fnf/src/viewPost.dart';

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
  TextEditingController confPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage('assets/images/register_background2.png'),
    fit: BoxFit.cover),
    ),
        child: Center(
            //child: Form(
            //key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                  width: 320, // set width
                  height: 320,
                  child: Image.asset('assets/images/logo1.png'),
                ),
                Container(
                  alignment: Alignment.center,
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
                    controller: usernameController,
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
                    //obscureText: true,
                    controller: emailController,
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
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: confPassController,
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
                      fillColor: const Color.fromRGBO(
                          255, 255, 255, 0.18), // 18% opacity white
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(

                  child: Form(
                    key: _formKey,
                    child: SizedBox(
                      //width: MediaQuery.of(context).size.width * 0.605,
                      height: 47,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xFF000000),
                        ),
                        onPressed: () async {
                          //if (_formKey.currentState.validate()) {
                            dynamic result = await _auth.registerWithEmailAndPassword(
                                emailController.text.trim(),
                                passwordController.text.trim(), usernameController.text.trim());

                            if (result != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => viewPost()),
                              );
                            }
                            else {
                              // reload the page
                              emailController.clear();
                              usernameController.clear();
                              passwordController.clear();
                              confPassController.clear();
                            }
                            /*dynamic result =
                                  await _auth.registerWithEmailAndPassword(
                                      emailController.text.trim(),
                                      passwordController.text.trim());
                                   */
                            //call setUsername to be the user's username
                          //}
                        },


                        child: const Text(
                          'CREATE ACCOUNT',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login())
                        );
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        )
        )
    );
  }
}

