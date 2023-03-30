import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fnf/user_model.dart';

class DatabaseService {
  final String userID;
  DatabaseService({this.userID = ''});
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  Future setUserID(String newUserID) async => await usersCollection
      .doc(userID).set({'id': newUserID});
  Future setUsername(String newUsername) async => await usersCollection
      .doc(userID).set({'username': newUsername});

  /* NET NINJA WAY, SAME AS ABOVE THO
  Future updateUserData(String username) async {
    return await usersCollection.doc(userID).set({
    'username': username,
  });
  }
 */

  Future unfollow(String givenUserId) async {
    // pass in user id of another user
    // get that user's follower count, decrement it by one
    // get that user's list of followers, remove this user's id
    // get this user's follwing count, decrement it by one
    // get this user's list of following, remove that user's id
  }
  Future follow(String givenUserId) async {
    // pass in user id of another user
    // get that user's follower count, increment it by one
    // get that user's list of followers, add this user's id
    // get this user's follwing count, increment it by one
    // get this user's list of following, add that user's id
  }

  // getters and setters for various different variables

  // when a user signs up, auth will record their email/password
  // have it also make a random user id field
  // then call a setter method here which sends all that info to the user document in firecloud
}