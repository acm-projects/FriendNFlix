
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../services/navBar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: WantToWatchPage()));
}

class WantToWatchPage extends StatefulWidget {
  const WantToWatchPage({Key? key}) : super(key: key);

  @override
  State<WantToWatchPage> createState() => _WantToWatchPageState();
}

class _WantToWatchPageState extends State<WantToWatchPage> {
  List<Widget> movieWidgets = [];
  List<dynamic> movies = [];
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final loggedInUser = FirebaseAuth.instance.currentUser;

  getMovieRefs() async
  {

    print("warmer");
    movies = [];
    var userRef = _db.collection("users").doc(loggedInUser!.email);
    var userSnapshot = await userRef.get();
    var userData = userSnapshot.data();
    var wantToWathMovies = userData!["favoritedFilms"];

    for(dynamic movie in wantToWathMovies){
      print("once");
      String movieTitle = movie.toString();
      var movieQuerySnapshot = await _db.collection("movies").where("title", isEqualTo: movieTitle).get();
      var movieSnapshot;
      if(movieQuerySnapshot != null && movieQuerySnapshot.docs.length > 0) {
        print("twice");
        movieSnapshot = movieQuerySnapshot.docs[0];
      }
      if(movieSnapshot != null){
        print("thrice");
        movies.add(movieSnapshot.data());
      }
    }
    print("movie refs:");
    print(movies);
  }

  buildMovieWidgets() async {

    // File file = File("imdb_top_1000.csv");
    // print("BEFORE file");
    // List<String> lines = file.readAsLinesSync();
    // for (String line in lines) {
    //   print(line);
    // }
    // print("AFTER file");

    movieWidgets = [];
    for (dynamic movie in movies) {
      String imageURL = movie["posterLink"];

      Widget imageWidget;
      if(imageURL == ""){
        imageWidget = Container(
          height: 160,
          width: 140,
          decoration: BoxDecoration(
            color: Color(0xFFEAE2B7),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 4,
                offset: Offset(2, 6),
              ),
            ],
          ),
        );
      } else {
        imageWidget = Container(
            height: 160,
            width: 140,
            child: Image.network(imageURL, fit: BoxFit.fitHeight)
        );
      }

      // set the correct amount of stars to yellow based on user rating

      Widget movieWidget = Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(40, 10, 12, 10),
              ),
              imageWidget,
              Padding(
                padding: EdgeInsets.all(16),
              ),
              Column(children: [
                // show title that post is about
                Text(movie["title"],
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                // row of stars
                // button to click on to go to post view
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey),
                    onPressed: () {
                      print('clicked on button for ${movie["title"]}');


                    },
                    child: Text("View Details",
                        style: TextStyle(
                            fontSize: 18
                        )))
              ]),
            ],
          ));
      movieWidgets.add(movieWidget);
    }
    setState(() {});
  }

  void setUp() async {
    await getMovieRefs();
    buildMovieWidgets();

  }
  @override
  void initState() {
    // _loadCSV(); call once to parse csv and add movies to database
    setUp();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    // build each MOVIE widget using the posts attribute
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(""),
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios,
                color: Color(0xFFAF3037),
                size: 30),
          ),
          // title: Text("Posts",
          //     style: TextStyle(
          //         color: Color(0xFFAF3037),
          //         fontSize: 25,
          //         fontWeight: FontWeight.bold)),
          // centerTitle: true,
          backgroundColor: Colors.white,
          actionsIconTheme: const IconThemeData(
            color: Colors.green,
            size: 30,
          ),
          elevation: 0,
        ),
        bottomNavigationBar: navBar(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                child: Center(
                  child: Text("Want to Watch",
                      style: TextStyle(
                          color: Color(0xFFAF3037),
                          fontSize: 25,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              //Divider(
              // color: Color(0xFFAF3037),
              // thickness: 2,
              //),
              /*Container(
            padding: EdgeInsets.all(15.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search for followers",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.4, color: Color(0xFFAF3037)),
                ),
              ),
            ),
          */ //),
              Column(children: movieWidgets),
            ],
          ),
        ));
  }
}