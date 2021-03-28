import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User get getUser => _auth.currentUser;
  Stream<User> get user => _auth.authStateChanges();

  Future<UserCredential> anonLogin() async {
    UserCredential user = await _auth.signInAnonymously();
    updateUserData(user);
    return user;
  }

  Future<UserCredential> googleSignIn() async {
    try {
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;

      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential user = await _auth.signInWithCredential(credential);
      updateUserData(user);
      return user;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<void> updateUserData(UserCredential user) {
    DocumentReference reportRef = _db.collection('reports').doc(user.user.uid);

    return reportRef.set({'uid': user.user.uid, 'lastActivity': DateTime.now()},
        SetOptions(merge: true));
  }

  Future<void> signOut() {
    return _auth.signOut();
  }
}
