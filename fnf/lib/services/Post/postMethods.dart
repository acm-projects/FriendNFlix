import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:fnf/services/Calendar/CalendarMethods.dart';
import 'Post.dart';

class PostMethods {

  // get all of current user's posts
  getCurrentUsersPosts() async {
    var currentUser = FirebaseAuth.instance.currentUser;
    String? userIdentifier = currentUser?.email;

    return getUsersPost(userIdentifier);
  }

  getPostWithIdentifier(String identifier) async {
    final user = FirebaseAuth.instance.currentUser;
    String? userEmail = user?.email;

    final userRef = db.collection("users").doc(userEmail);

    final ref = userRef.collection("posts").doc(identifier).withConverter(
      fromFirestore: Post.fromFirestore,
      toFirestore: (Post post, _) => post.toFirestore(),
    );

    final docSnap = await ref.get();
    final post = docSnap.data(); // Convert to Post object
    if (post != null) {
      return post;
    } else {
      return null;
    }
  }

  // delete a post, given the identifier
  deletePostWithIdentifier(String identifier) async {

    // side note: do we have to check every post? or can we just do.(id) and let firebase find it?

    // assume only the original poster can delete a post; will need
    // to change this assumption if admin accounts are made
    final currentUser = FirebaseAuth.instance.currentUser;
    String? userIdentifier = currentUser?.email;
    final userRef = db.collection("users").doc(userIdentifier);
    final postSnapshots = await userRef.collection("posts").get();
    for(var postSnapshot in postSnapshots.docs){
      String postId = postSnapshot.id;
      if(postId != identifier) continue;

      await userRef.collection("posts").doc(postId).delete();
    }
  }

  // get user's posts given the user identifier
  getUsersPost (String? userIdentifier) async {
    if(userIdentifier == null) return null;

    List<Post> posts = [];

    var userRef = db.collection("users").doc(userIdentifier);
    var postQuerySnapshot =
    await userRef.collection("posts").get();

    for (var postSnapshot in postQuerySnapshot.docs) {
      String postId = postSnapshot.id;


      final ref = userRef.collection("posts").doc(postId).withConverter(
        fromFirestore: Post.fromFirestore,
        toFirestore: (Post post, _) => post.toFirestore(),
      );

      final docSnap = await ref.get();
      final post = docSnap.data(); // Convert to Post object

      if (post != null) {
        posts.add(post);
      }
    }

    return posts;
  }

  // get all posts (from every user), sorted by creation time
  getAllPosts() async{
    List<Post> posts = [];

    var userQuerySnapshot = await db.collection("users").get();

    // for every user, get their posts
    for (var userSnapshot in userQuerySnapshot.docs) {
      var userId = userSnapshot.id;
      List<Post> userPosts = await getUsersPost(userId);
      if(userPosts != null) posts.addAll(userPosts);
    }

    return posts;
  }

  // get all posts using given an array of identifiers
  getPostWithIdentifiers(List<String> identifiers) async{
    List <Post> posts = [];
    for(String postId in identifiers){
      var post = await getPostWithIdentifier(postId);
      if (post != null) posts.add(post);
    }

    return posts;
  }

  addPostToFirestore(Post post) async {

    print("slightly closer");
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser;

    print("closer");

    // creates collection if not yet made and adds
    var usersCollectionRef = await db.collection("users");
    var userRef = await usersCollectionRef.doc(user?.email);
    var postRef = userRef.collection("posts").withConverter(
        fromFirestore: Post.fromFirestore,
        toFirestore: (Post post, options) => post.toFirestore()).doc();
    await postRef.set(post);
    print(postRef.id);

    var postDoc = await postRef.get();

    CalendarMethods calendarMethods = CalendarMethods();
    calendarMethods.addPostToCalendar(postDoc.id, post!.watchMonth, post.watchDay, post.watchYear);
  }
}