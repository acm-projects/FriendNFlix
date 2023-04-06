import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fnf/user_model.dart';
import 'package:fnf/services/auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final users = FirebaseAuth.instance.currentUser;
    final AuthService _auth = AuthService();

    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: SingleChildScrollView(
        child: Column(
        children: [
            //Text('${users?.email}', style: TextStyle(fontSize: 40),),
            StreamBuilder<List<Users>>(
              stream: readUser(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Invalid');
                } else if (snapshot.hasData) {
                  final users = snapshot.data!;

                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: users.length,
                      itemBuilder: (context, index) =>
                          ListTile(title: Text(users[index].username)));
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Container(),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent),
              onPressed: () async {
                await _auth.signOut();
                //FirebaseAuth.instance.signOut();
              },
              child: Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}

Stream<List<Users>> readUser() =>
    FirebaseFirestore.instance.collection('users').snapshots().map((snapshot) =>
        snapshot.docs.map((e) => Users.fromJson(e.data())).toList());

/* TO DO:
- Firebase dataset wtf is he talking about, a million getters and setters
- methods for login and register page

- Auth class to streamline Firebase methods (sign in with email, sign up with email, etc.)
*/