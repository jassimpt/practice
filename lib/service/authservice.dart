import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hivepractice/db/model/usermodel.dart';

class FireAuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  signupWithEmail(String email, String password, String name) async {
    try {
      UserCredential user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      final UserModel userdata =
          UserModel(email: email, name: name, uid: user.user!.uid);

      await firestore
          .collection('users')
          .doc(user.user!.uid)
          .set(userdata.toJson());
      return user;
    } catch (e) {
      throw Exception(e);
    }
  }

  signInWithEmail(String email, String password) async {
    try {
      UserCredential user = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return user;
    } catch (e) {
      throw Exception(e);
    }
  }

  void signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }
}
