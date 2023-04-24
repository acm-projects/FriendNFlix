import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fnf/services/user_model.dart';
import 'package:googleapis/analytics/v3.dart';

class DatabaseService {
  final String userID;

  DatabaseService({this.userID = ''});

  final CollectionReference usersCollection = FirebaseFirestore.instance
      .collection('users');

  // these methods are used in Auth during account creation to store data in firebase
  Future setEmail(String email) async =>
      await usersCollection
          .doc(userID).set({'email': email},
          SetOptions(merge: true)); // a separate email field is kept jic
  Future setUsername(String newUsername) async =>
      await usersCollection
          .doc(userID).set({'username': newUsername}, SetOptions(merge: true));

  Future getUserWithID(String id) async =>
      await usersCollection
          .doc(id).get();

  Future<String> getUsernameFromID(String id) async {
    QuerySnapshot snapshot = await usersCollection.get();
    for (QueryDocumentSnapshot doc in snapshot.docs) {
      if (doc.id == id) {
        return doc.get("username");
      }
    }
    return "Stupid";
  }

  Future<int> getNumFollowersFromID(String id) async {
    QuerySnapshot snapshot = await usersCollection.get();
    for (QueryDocumentSnapshot doc in snapshot.docs) {
      if (doc.id == id && doc.get("followers") != null) {
        return doc
            .get("followers")
            .length;
      }
    }
    return 0;
  }

  Future<int> getNumFollowingFromID(String id) async {
    QuerySnapshot snapshot = await usersCollection.get();
    for (QueryDocumentSnapshot doc in snapshot.docs) {
      if (doc.id == id && doc.get("following") != null) {
        return doc
            .get("following")
            .length;
      }
    }
    return 0;
  }

  Future<int> getPostCount(String userID) async {
    QuerySnapshot snapshot = await usersCollection.doc(userID).collection(
        "posts").get();
    return snapshot.size;
  }

  Future<List<String>> getUsernamesFromIds(List<String> ids) async {
    List<String> usernames = [];
    print(ids);
    for (String id in ids) {
      usernames.add(await getUsernameFromID(id));
    }
    return usernames;
  }

  Future unfollow(String loggedInUser, otherUser) async {
    // get this user's list of following, check if the passed in user is in the list
    // if so, then remove that user's id
    // get this user's following count

    /*
    afterwards, repeat this process with the givenUserId instead of userID
    to get the snapshot of the targeted user's collection


     */

    // get that user's list of followers, remove this user's id
    }
    Future follow(String loggedInUser, String otherUser) async {
      // pass in user id of another user
      // get that user's list of followers, add this user's id
      // get this user's list of following, add that user's id

      //QuerySnapshot?
      dynamic snapshot = await usersCollection.doc(loggedInUser).collection(
          "following").get();
      if (snapshot.contains(otherUser)) {
        return false; // have profile do an if check, if true then reload page to show updated count
      }
      snapshot.add(await otherUser);
      // SetOptions(merge: true)?

      snapshot = await usersCollection.doc(otherUser).collection(
          "followers").get();
      if (snapshot.contains(loggedInUser)) {
        return false; // have profile do an if check, if true then reload page to show updated count
      }
      snapshot.add(await loggedInUser);

      return true;
      /*for (QueryDocumentSnapshot doc in snapshot.docs) {
        if (doc.get('userID') != loggedInUser)
          continue;
        else {
          final followers = doc.get('followers');

        }
      } */
    }

    // getters and setters for various different variables

    // when a user signs up, auth will record their email/password
    // then call a setter method here which sends all that info to the user document in firecloud
  }