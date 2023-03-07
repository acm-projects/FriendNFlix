import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final users = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text('${users?.email}', style: TextStyle(fontSize: 40),),

            const SizedBox(height: 10,),
            Center(
              child: Container (

              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orangeAccent),
              onPressed: (){
                FirebaseAuth.instance.signOut();
              },
              child: Text(
                  'Log Out'
              ),
            ),
          ],
        ),
      ),
    );
  }
}
