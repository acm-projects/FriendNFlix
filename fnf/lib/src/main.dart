import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fnf/services/Post/PostsView.dart';
import '../profile/Feed.dart';
import '../profile/otherProfile.dart';
import 'login.dart';
import 'viewPost.dart';

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
            return const Login();
          } else {
            return FeedPage();
          }
        },

        ),
      );
  }
}

/*
MUST HAVE'S BEFORE MOCK:
- finish profile/subprofile page navigation // DONE, ALTHOUGH FIX DATA NULL ERROR WHEN PUSHING TO PROFILE
- have profile use username instead of text filler // DONE
- finish register method --> NEED TO WRAP UP, SENDS TO AUTH BY NOT TO DATABASE
                            // ALSO CANT OPEN UP FOLLOWERS/FOLLOWING WHEN NULL
- add signout feature (are you sure you want to sign out message possibly?)

MUST HAVE'S BEFORE PRESENTATION:
- following feature fully implemented
- postPage from Byron done
- search feature done
- input validation on login/register? (not like they will see it)


- do database stuff for followers and profile page (need to rewrite following/follower/posts/profile/otherProfile
  so that the states accept user parameters when being pushed to and also change all the navigation pushes to use the
  user document accordingly
- finish designing the follower page, then paste everything over to following page
- redo methods for following page to be nearly identical
- reroute profile/follower/following pages to use userID, use a stack pop for post's back button
- make otherProfile's icon an iconButton that routes to otherProfile again
- check what happens when a profile with no followers opens up follower page (error or nothing?)
- push to github and pray
*/