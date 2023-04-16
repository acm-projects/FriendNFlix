import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'viewPost.dart';
import 'package:fnf/services/auth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const Login(); // uncomment once viewPost class is made, operates as feed page
          } else {
            return const viewPost(); // LoginPage();
          }
        },
        ),
      );
  }
}

/*
- do database stuff for followers and profile page
- then redo user auth for avanthi's new login/register pages
- do input validation on the login/register pages, also do error message on failed login where the comment is
- integrate the profile page
- push to github
 */