import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fnf/profile/otherProfile.dart';

import '../createPost/CreatePost1.dart';
import '../profile/profile.dart';
import '../src/viewPost.dart';
import 'database.dart';

class navBar extends StatefulWidget {
  navBar({Key? key}) : super(key: key);


  @override
  State<navBar> createState() => _navBarState();
}
  class _navBarState extends State<navBar> {
    final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 75,
        child: BottomAppBar(
          color: Colors.black,
        child: Column(
            children: [
          Align(
              alignment: Alignment.center,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(18.0, 0.0, 0.0, 5.0),
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 12),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => viewPost()),
                            );
                          },
                          icon: const Icon(
                            Icons.home,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                        const SizedBox(width: 95),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CreatePost1()),
                            );
                          },
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                        const SizedBox(width: 95),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Profile(userID: user!.email!)),
                                      //otherProfile(userID: user!.email!)),
                                      //Profile(userID: user!.email!)),

                            );
                          },
                          icon: const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                        /*
            IconButton(
                onPressed: () {},
                  icon: Icon(
                   Icons.thumb_up,
                   color: Colors.white,
                    size: 35,
                    ),
               ),
             */
                      ])))
        ])));
  }
}
