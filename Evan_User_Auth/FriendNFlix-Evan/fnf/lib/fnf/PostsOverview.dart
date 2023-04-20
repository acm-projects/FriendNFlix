import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fnf/main.dart';
import 'package:path_provider/path_provider.dart';

import 'Classes/Post.dart';
import 'PostsView.dart';

class PostsOverviewPage extends StatefulWidget {
  PostsOverviewPage({Key? key, required this.postRefs}) : super(key: key);
  List<dynamic> postRefs;

  @override
  State<PostsOverviewPage> createState() => _PostsOverviewPageState();
}

class _PostsOverviewPageState extends State<PostsOverviewPage> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  String username = "";
  List<List<dynamic>> _data = [];

  List<Widget> postOverviewWidgets = [];

  void _loadCSV() async {
    List<String> posterLinks = [];
    List<String> movieTitles = [];
    List<String> yearsReleased = [];
    List<String> certificates = [];
    List<String> runTimes = [];
    List<String> genres = [];
    List<String> imdbRatings = [];
    List<String> overviews = [];
    List<String> metaScores = [];
    List<String> directors = [];
    List<String> mainStars = [];
    List<String> secondaryStars = [];
    List<String> thirdStars = [];
    List<String> fourthStars = [];
    List<int> voteCounts = [];
    List<String> grossRevenues = [];

    List<String> allItems = [];
    List<Map<String, dynamic>> movies = [];
    String rawData = await rootBundle.loadString("files/imdb_top_1000.csv");
    _data = CsvToListConverter().convert(rawData);
    bool isFirstLine = true;
    for(List<dynamic> line in _data){

      if(isFirstLine){
        isFirstLine = false;
        continue;
      }

      // posterLinks.add(line.removeAt(0).toString());
      //
      // movieTitles.add(line.removeAt(0).toString());
      //
      // yearsReleased.add(line.removeAt(0).toString());
      //
      // certificates.add(line.removeAt(0).toString());
      // runTimes.add(line.removeAt(0).toString());
      // genres.add(line.removeAt(0).toString());
      //
      // imdbRatings.add(line.removeAt(0).toString());
      // overviews.add(line.removeAt(0).toString());
      // metaScores.add(line.removeAt(0).toString());
      // directors.add(line.removeAt(0).toString());
      // mainStars.add(line.removeAt(0).toString());
      // secondaryStars.add(line.removeAt(0).toString());
      // thirdStars.add(line.removeAt(0).toString());
      // fourthStars.add(line.removeAt(0).toString());
      // voteCounts.add(line.removeAt(0));
      // grossRevenues.add(line.removeAt(0).toString());
      //
      final movieData = <String, dynamic>{
        "posterLink" : line.removeAt(0).toString(),
        "title" : line.removeAt(0).toString(),
        "yearReleased" : line.removeAt(0).toString(),
        "certificate" : line.removeAt(0).toString(),
        "runTime" : line.removeAt(0).toString(),
        "genres" : line.removeAt(0).toString(),
        "imdbRating" : line.removeAt(0).toString(),
        "overview" : line.removeAt(0).toString(),
        "metaScore" : line.remove(0).toString(),
        "director" : line.removeAt(0).toString(),
        "stars" : [ line.removeAt(0).toString(), line.removeAt(0).toString(), line.removeAt(0).toString(), line.removeAt(0).toString()],
        "voteCount" : line.removeAt(0),
        "grossRevenue": line.removeAt(0).toString()
      };
      await _db.collection("movies").add(movieData);
      movies.add(movieData);
    }
    print(movies.length);
    print("finito");
  }

  buildPostOverviewWidgets() async {

    // File file = File("imdb_top_1000.csv");
    // print("BEFORE file");
    // List<String> lines = file.readAsLinesSync();
    // for (String line in lines) {
    //   print(line);
    // }
    // print("AFTER file");

    postOverviewWidgets = [];
    for (dynamic postRef in widget.postRefs) {
      final docSnap = await postRef.get();
      final post = docSnap.data(); // Convert to Post object
      final moviesQuery = await _db.collection("movies").where("title", isEqualTo: post.filmTitle).get();
      String? imageURL = "";

      if(moviesQuery != null && moviesQuery.docs != null && moviesQuery.docs.length > 0){
        print('reached here for post about ${post.filmTitle}');

        final movieRef = moviesQuery.docs[0];
        imageURL = movieRef.data()["posterLink"];
        if(imageURL == null) {
          print("could not find a url");
          imageURL = "";
        }
      }

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

      // set all the stars to grey
      List<Color> starColors = [
        Colors.grey,
        Colors.grey,
        Colors.grey,
        Colors.grey,
        Colors.grey
      ];

      // set the first n stars to grey, where n is the star rating
      for (int i = 0; i < post.starRating; i++) {
        starColors[i] = Color(0xFFFAE20D);
      }

      Widget PostOverviewWidget = Padding(
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
                Text(post.filmTitle.isEmpty ? "BLANK TITLE" : post.filmTitle,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                // row of stars
                Row(children: [
                  Icon(
                    Icons.star,
                    color: starColors[0],
                    size: 25,
                  ),
                  Icon(
                    Icons.star,
                    color: starColors[1],
                    size: 25,
                  ),
                  Icon(
                    Icons.star,
                    color: starColors[2],
                    size: 25,
                  ),
                  Icon(
                    Icons.star,
                    color: starColors[3],
                    size: 25,
                  ),
                  Icon(
                    Icons.star,
                    color: starColors[4],
                    size: 25,
                  ),
                ]),
                // button to click on to go to post view
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey),
                    onPressed: () {
                      print('clicked on button for ${post.filmTitle} post');

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PostsViewPage(postRefs: [postRef])));
                    },
                    child: Text("View Details",
                    style: TextStyle(
                      fontSize: 18
                    )))
              ]),
            ],
          ));
      postOverviewWidgets.add(PostOverviewWidget);
    }
    setState(() {});
  }

  @override
  void initState() {
    // _loadCSV(); call once to parse csv and add movies to database
    buildPostOverviewWidgets();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // build each post widget using the posts attribute
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(""),
          leading: Icon(
            Icons.arrow_back_ios,
            color: Color(0xFFAF3037),
            size: 30,
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
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'message',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'profile',
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              // Container(
              //   child: Align(
              //     alignment: Alignment(-0.90, -1.0),
              //     child: Icon(
              //       Icons.arrow_back_ios,
              //       color: Color(0xFFAF3037),
              //       size: 30,
              //     ),
              //   ),
              // ),
              Container(
                child: Center(
                  child: Text("Posts",
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
              Column(children: postOverviewWidgets),
            ],
          ),
        ));
  }
}
