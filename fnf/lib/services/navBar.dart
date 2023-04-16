import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../createPost/createPost1.dart';
import '../profile/profile.dart';
import '../src/viewPost.dart';

class navBar extends StatelessWidget {
  const navBar({Key? key}) : super(key: key);

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
                                  builder: (context) => const viewPost()),
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
                                  builder: (context) => const Profile()),
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
