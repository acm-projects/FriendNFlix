import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // this function is called everytime the input is focused on and whenever the
  // text inside changes
  void _emailInputListener() {
    print('Email input text: ${_emailController.text}');
  }

  void _passwordInputListener() {
    print('Password input text: ${_passwordController.text}');
  }

  // initiate text input controllers and add listeners to them
  @override
  void initState() {
    super.initState();

    _emailController.addListener(_emailInputListener);
    _passwordController.addListener(_passwordInputListener);
  }

  // dispose the text input controllers when the widget is disposed
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // define what the login page looks like
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FriendNFlix Login'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    width: MediaQuery.of(context).size.width * .8,
                    child: TextField(
                        controller: _emailController,
                        style: const TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Email',
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 25),
                          border: InputBorder.none,
                        )))),
            const SizedBox(
              height: 10,
            ),
            Center(
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    width: MediaQuery.of(context).size.width * .8,
                    child: TextField(
                        controller: _passwordController,
                        style: const TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Password',
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 25),
                          border: InputBorder.none,
                        )))),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange),
                onPressed: () async {

                  try {
                    UserCredential result = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim());

                    // todo
                    // check if user is in firestore (not just auth database)
                    // if not, add them
                    print("logged in succesfully");
                  } catch(err){
                    print("error logging in");
                  }
                }, // button does nothing for now
                child: Text('Login')),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent),
                onPressed: () async {
                  var email = _emailController.text.trim();
                  var password = _passwordController.text.trim();

                  var userCred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: email,
                      password: password);

                  var user = userCred.user;

                  var db = FirebaseFirestore.instance;

                  print("TAG");

                  var userRef = db.collection("users").doc(email);
                  userRef.set({ email : email });

                }, // this button also does nothing for now
                child: Text('Signup')),
          ],
        ),
      ),
    );
  }
}
