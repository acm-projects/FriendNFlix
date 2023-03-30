import 'package:firebase_auth/firebase_auth.dart';
import 'package:fnf/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Users? _user(User user) {
    return user != null ? Users(uid: user.uid) : null;
  }

  // onAuthStateChanged --> authStateChanges()
  // Firebase User --> User?
  Stream<Users?> get user {
    return _auth.authStateChanges().map((User? user) => _user(user!));
  }
  // sign in with email and password
  Future signIn(String email, String password) async {
    try {
      //UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _user(user!);
    }
    catch(e) {
      print(e.toString());
      return null;
    }
  }
  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _user(user!);
    }
    catch(e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    }
    catch (e) {
      return null;
    }
  }

}