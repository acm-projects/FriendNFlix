import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fnf/services/auth.dart';

import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(home: Login() ,));

}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: const Color(0xFFAF3037),
      body: Center(

      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02, // move everything down by 20%
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
                  fillColor: Color.fromRGBO(255, 255, 255, 0.18), // 18% opacity white
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
                  fillColor: Color.fromRGBO(255, 255, 255, 0.18), // 18% opacity white
                ),
              ),
            ),
            SizedBox(height: 20),
            /*TextFormField(
              validator: (val) => val!.isEmpty ? 'Enter an email' : null;
              validator: (val) => val!.length < 6 ? "Enter a password 6+ chars" : null;
              onChanged: (val) {
                setState(() => email = val);
              }
            ),*/
            Center(
              child: ElevatedButton(
                    child: Text(
                      'Sign In',
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
                      if(_formKey.currentState!.validate()) {
                        dynamic result = await _auth.signIn(emailController.text.trim(), passwordController.text.trim());
                        if(result == null) {
                          //setState(() => error = 'login not recognized, please try again');
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const HomePage()),
                          );
                        }
                      }
                    },

              ),
            ),

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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HomePage()),
                      );
                      //signup screen
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
          ],
        ),
      ),
      )
      )
    );
  }
}