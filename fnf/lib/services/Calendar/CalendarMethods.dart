import 'dart:async';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Day.dart';
import 'Month.dart';
import 'package:fnf/services/Post/Post.dart';
import 'package:fnf/services/Post/PostMethods.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class CalendarMethods {
  CalendarMethods(){

  }

  // get month given month and year

  // get day given day, month, and year

  // add post identifier to correct day (create day or month if necessary)
  addPostToCalendar(
      String postId, int monthToAddTo, int dayToAddTo, int yearToAddTo) async {
    final userId = FirebaseAuth.instance.currentUser?.email;
    final userRef = await db.collection("users").doc(userId);

    if (userRef == null) return;

    final userDoc = await userRef.get();
    var monthsQuerySnapshot = await userRef.collection("months").get();

    // look for correct month
    String monthId = "";
    for (var monthSnapshot in monthsQuerySnapshot.docs) {
      String currentMonthId = monthSnapshot.id;
      var monthDoc =
      await userRef.collection("months").doc(currentMonthId).get();
      int currentMonth = monthDoc.data()?["monthNum"];
      int currentYear = monthDoc.data()?["yearNum"];

      if (currentMonth == monthToAddTo && currentYear == yearToAddTo) {
        monthId = currentMonthId;
        break;
      }
    }

    // if month was not found, create it
    if (monthId.isEmpty) {
      Month month = Month(month: monthToAddTo, year: yearToAddTo);

      // creates collection if not yet made and adds
      var monthRef = userRef
          .collection("months")
          .withConverter(
          fromFirestore: Month.fromFirestore,
          toFirestore: (Month month, options) => month.toFirestore())
          .doc();
      await monthRef.set(month);
      monthId = monthRef.id;
    }

    var monthRef = userRef.collection("months").doc(monthId);
    var dayQuerySnapshot = await monthRef.collection("days").get();

    String dayId = "";

    // look for correct day to add to (assuming it exists)
    for (var daySnapshot in dayQuerySnapshot.docs) {
      if (daySnapshot.data()["dayNum"] == dayToAddTo) {
        dayId = daySnapshot.id;
        break;
      }
    }

    // if day was not found, create it
    if (dayId.isEmpty) {
      Day day = Day(dayNum: dayToAddTo, monthNum: monthToAddTo, yearNum: yearToAddTo);

      // creates collection if not yet made and adds
      var dayRef = monthRef
          .collection("days")
          .withConverter(
          fromFirestore: Day.fromFirestore,
          toFirestore: (Day day, options) => day.toFirestore())
          .doc();
      await dayRef.set(day);
      dayId = dayRef.id;
    }

    final dayRef = await monthRef.collection("days").doc(dayId);
    await dayRef.update({
      "postIds": FieldValue.arrayUnion([postId])
    });
  }

  Future<List<Post>> getPostsForMonth(int month, int year) async {
    List<Post> posts = [];

    final userId = FirebaseAuth.instance.currentUser?.email;
    final userRef = await db.collection("users").doc(userId);

    var monthsQuerySnapshot = await userRef.collection("months").get();
    for(var monthSnapshot in monthsQuerySnapshot.docs){
      String monthId = monthSnapshot.id;


      final ref = userRef.collection("months").doc(monthId).withConverter(
        fromFirestore: Month.fromFirestore,
        toFirestore: (Month month, _) => month.toFirestore(),
      );

      final docSnap = await ref.get();
      final month = docSnap.data(); // Convert to Month object

      if(month?.yearNum == year && month?.monthNum == month){
        var daysQuerySnapshot = await ref.collection("days").get();
        for(var daySnapshot in daysQuerySnapshot.docs){
          var dayId = daySnapshot.id;
          var dayDoc = await ref.collection("days").doc(dayId).get();

          //todo
          // posts.addAll(await getPostsForDay(dayDoc.data()?["monthNum"], dayDoc.data()?["dayNum"], dayDoc.data()?["yearNum"]));
        }
      }
    }
    return posts;
  }

  streamPostForDay(int month, int day, int year, StreamController<Post> controller) async {
    List<Post> posts = [];

    final userId = FirebaseAuth.instance.currentUser?.email;
    final userRef = await db.collection("users").doc(userId);

    var monthsQuerySnapshot = await userRef.collection("months")
        .where("monthNum", isEqualTo: month)
        .where("yearNum", isEqualTo: year)
        .get();


    for(var monthSnapshot in monthsQuerySnapshot.docs){
      String monthId = monthSnapshot.id;

      final monthRef = userRef.collection("months").doc(monthId).withConverter(
        fromFirestore: Month.fromFirestore,
        toFirestore: (Month month, _) => month.toFirestore(),
      );

      final monthDoc = await monthRef.get();
      final monthObject = monthDoc.data(); // Convert to Month object

      var daysQuerySnapshot = await monthRef.collection("days")
          .where("dayNum", isEqualTo : day)
          .get();

      for(var daySnapshot in daysQuerySnapshot.docs){
        var dayId = daySnapshot.id;

        var dayRef = monthRef.collection("days").doc(dayId).withConverter(
          fromFirestore: Day.fromFirestore,
          toFirestore: (Day day, options) => day.toFirestore(),
        );


        final dayDoc = await dayRef.get();
        final dayObject = dayDoc.data(); // Convert to Day object


        List<String>? postIds = dayObject?.postsIds;
        if(postIds!.isEmpty) return;

        for(String postId in postIds){

          var post = await PostMethods().getPostWithIdentifier(postId);
          if(post != null) {
            controller.add(post);
          }

        }
      }
    }
  }


  getPostsForDay(int month, int day, int year,) async {
    List<Post> posts = [];

    final userId = FirebaseAuth.instance.currentUser?.email;
    final userRef = await db.collection("users").doc(userId);

    var monthsQuerySnapshot = await userRef.collection("months")
        .where("monthNum", isEqualTo: month)
        .where("yearNum", isEqualTo: year)
        .get();


    for(var monthSnapshot in monthsQuerySnapshot.docs){
      String monthId = monthSnapshot.id;

      final monthRef = userRef.collection("months").doc(monthId).withConverter(
        fromFirestore: Month.fromFirestore,
        toFirestore: (Month month, _) => month.toFirestore(),
      );

      final monthDoc = await monthRef.get();
      final monthObject = monthDoc.data(); // Convert to Month object

      var daysQuerySnapshot = await monthRef.collection("days")
          .where("dayNum", isEqualTo : day)
          .get();


      for(var daySnapshot in daysQuerySnapshot.docs){
        var dayId = daySnapshot.id;

        var dayRef = monthRef.collection("days").doc(dayId).withConverter(
          fromFirestore: Day.fromFirestore,
          toFirestore: (Day day, options) => day.toFirestore(),
        );


        final dayDoc = await dayRef.get();
        final dayObject = dayDoc.data(); // Convert to Day object


        List<String>? postIds = dayObject?.postsIds;

        for(String postId in postIds!){

          var post = await PostMethods().getPostWithIdentifier(postId);
          if(post != null) {
            posts.add(post);
          }
        }
      }
    }
    print('these are all post found for given day ${month} / ${day} / ${year}');
    for(Post post in posts){
      print(post.body);
    }
    print("DONE printing post FOR GIEVN DAY");
    return posts;
  }

}