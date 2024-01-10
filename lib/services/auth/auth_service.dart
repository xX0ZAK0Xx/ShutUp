import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //--------- Instance of Auth & Frestore--------
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //-------- get current user -------------
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  //---------- Sign In -------------
  Future<UserCredential> signInWithEmailPassword(String email, password) async {
    try {
      // Sign user in
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      //------- Save user info if it doesnt already exist
      _firestore.collection("Users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': userCredential.user!.email,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //---------- Sign up --------------------
  Future<UserCredential> signUpWithEmailPassword(
      String email, String password) async {
    try {
      //-------- Create User -----------
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      //---------- Save User in a separate doc ------------
      _firestore.collection("Users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': userCredential.user!.email,
      });
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //---------- Sign out --------------------
  Future<void> signOut() async {
    return await _auth.signOut();
  }

  //---------- errors --------------------
}
