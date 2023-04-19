import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fnf/services/user_model.dart';
import 'package:googleapis/analytics/v3.dart';

class DatabaseService {
  final String userID;
  DatabaseService({this.userID = ''});
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  Future setEmail(String email) async => await usersCollection
      .doc(userID).set({'email': email}, SetOptions(merge: true)); // a separate email field is kept jic
  Future setUsername(String newUsername) async => await usersCollection
      .doc(userID).set({'username': newUsername}, SetOptions(merge: true));

  Future getUserWithID(String id) async => await usersCollection
      .doc(id).get();
  Future<String> getUsernameFromID(String id) async {
    QuerySnapshot snapshot = await usersCollection.get();
    for(QueryDocumentSnapshot doc in snapshot.docs)
    {
      if(doc.id == id)
      {
        return doc.get("username");
      }
    }
    return "Stupid";
  }

  Future<int> getNumFollowersFromID(String id) async {
    QuerySnapshot snapshot = await usersCollection.get();
    for(QueryDocumentSnapshot doc in snapshot.docs)
    {
      if(doc.id == id && doc.get("followers")!= null)
      {
        return doc.get("followers").length;
      }
    }
    return 0;
  }
  Future<int> getNumFollowingFromID(String id) async {
    QuerySnapshot snapshot = await usersCollection.get();
    for(QueryDocumentSnapshot doc in snapshot.docs)
    {
      if(doc.id == id && doc.get("following")!= null)
      {
        return doc.get("following").length;
      }
    }
    return 0;
  }
  Future<int> getPostCount(String userID) async {
    QuerySnapshot snapshot = await usersCollection.doc(userID).collection("posts").get();
    return snapshot.size;
  }
  Future<List<String>> getUsernamesFromIds(List<String> ids) async {
    List<String> usernames = [];
    print(ids);
    for(String id in ids)
      {
        usernames.add(await getUsernameFromID(id));
      }
    return usernames;
  }

  Future getFollowers(String givenUserID) async {


  }
  Future getFollowing(String givenUserID) async {


  }

  Future unfollow(String givenUserId) async {
    // get this user's list of following, check if the passed in user is in the list
    // if so, then remove that user's id
    // get this user's following count, decrement it by one
    QuerySnapshot snapshot = await usersCollection.get();
    for (QueryDocumentSnapshot doc in snapshot.docs) {
      if(doc.get('userID') != userID)
        continue;
      else {
        final followers = doc.get('followers');  // this is wrong, change to be a list


      }
    }

    /*
    afterwards, repeat this process with the givenUserId instead of userID
    to get the snapshot of the targeted user's collection


     */

    // get that user's list of followers, remove this user's id
    // get that user's follower count, decrement it by one

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