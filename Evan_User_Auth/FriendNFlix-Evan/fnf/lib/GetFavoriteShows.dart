import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fnf/fnf/CalendarMethods.dart';
import 'package:fnf/fnf/PostMethods.dart';

import 'fnf/Classes/Post.dart';

class GetFavoriteShowsPage extends StatefulWidget {
  String userId;
  GetFavoriteShowsPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<GetFavoriteShowsPage> createState() => _GetFavoriteShowsPageState();
}

class _GetFavoriteShowsPageState extends State<GetFavoriteShowsPage> {
  List<Widget> favoriteShowsWidgets = [];

  // connect to firestore db
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final loggedInUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    buildFavoriteShowWidgets();


    super.initState();
  }

  buildFavoriteShowWidgets() async {
    List<Post> posts = await PostMethods().getUsersPost(widget.userId);
    PostMethods().sortPostsByMostStars(posts); // sorts post with highest stars being at the front
    List<String> highlyRatedFilms = [];

    Map<String, double> filmAverageStarRating = {};
    Map<String, int> filmAmountOfPosts = {};
    for(Post post in posts){
      int? amountOfPosts = filmAmountOfPosts[post.filmTitle];
      if(amountOfPosts == null) amountOfPosts = 0;

      amountOfPosts += 1;
      filmAmountOfPosts[post.filmTitle] = amountOfPosts;

      double? score = filmAverageStarRating[post.filmTitle];
      if(score == null) score = 0;

      score += post.starRating.toDouble();

      filmAverageStarRating[post.filmTitle] = score;
    }

    for(var entry in filmAverageStarRating.entries){
      double starValue = entry.value;
      int? denominator = filmAmountOfPosts[entry.key];
      if(denominator == null) denominator = 1;

      filmAverageStarRating[entry.key] = starValue / denominator;

      starValue /= denominator;
      if(starValue >= 4)
        highlyRatedFilms.add(entry.key);
    }

    // for(Post post in posts){
    //   if(post.starRating < 4) break;
    //   if(highlyRatedFilms.contains(post.filmTitle)) continue;
    //   else highlyRatedFilms.add(post.filmTitle);
    // }

    print("printing highly rated films");
    print(highlyRatedFilms);
    for(String film in highlyRatedFilms){
      var movieQuerySnapshot = await db.collection("movies").where(
        "title", isEqualTo: film
      ).get();

      if(movieQuerySnapshot.docs == null) continue;

      var movie = movieQuerySnapshot.docs[0];

     Widget filmWidget = Image.network(movie.data()["posterLink"]);
     // favoriteShowsWidgets.add(filmWidget);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: favoriteShowsWidgets
      )
    );
  }
}
