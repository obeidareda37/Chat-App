import 'package:firebase_auth/firebase_auth.dart';

class AuthHelper {
  AuthHelper._();

  static AuthHelper authHelper = AuthHelper._();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  signUp(String email, String password) async {
    //userCredential == info for user || IDf for user
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(await userCredential.user.getIdToken());
      print(userCredential.user.uid);

    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    }
    on Exception catch (e) {
      print(e);
    }
  }

  signIn(String email, String password) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(await userCredential.user.getIdToken());
      print(userCredential.user.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  resetPassword(String email) async {}

  verifyEmail(String email) async {}

  logOut() async {}
}
