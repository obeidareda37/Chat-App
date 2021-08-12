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
    } on Exception catch (e) {
      // TODO
    }
  }

  signIn(String email, String password) async {}

  resetPassword(String email) async {}

  verifyEmail(String email) async {}

  logOut() async {}
}
