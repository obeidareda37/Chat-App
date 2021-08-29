import 'package:chat_app/service/custom_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthHelper {
  AuthHelper._();

  static AuthHelper authHelper = AuthHelper._();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  String getUserId() {
    return firebaseAuth.currentUser.uid;
  }

  Future<UserCredential> signUp(String email, String password) async {
    //userCredential == info for user || IDf for user
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
      print(await userCredential.user.getIdToken());
      print(userCredential.user.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<UserCredential> signIn(String email, String password) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
      print(await userCredential.user.getIdToken());
      print(userCredential.user.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        CustomDialog.customDialog
            .showCustomDialog(message: 'No user found for that email.');
        // print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        CustomDialog.customDialog.showCustomDialog(
            message: 'Wrong password provided for that user.');
        // print('Wrong password provided for that user.');
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  resetPassword(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
    CustomDialog.customDialog.showCustomDialog(
        message:
            'we have sent email for reset password, please check your email');
  }

  verifyEmail() async {
    await firebaseAuth.currentUser.sendEmailVerification();
    CustomDialog.customDialog.showCustomDialog(
        message: 'verification email has been sent,please check your email');

    // print('verification email has been sent');
  }

  logOut() async {
    firebaseAuth.signOut();
  }

  bool checkEmailVerification() {
    return firebaseAuth.currentUser?.emailVerified ?? false;
  }

  bool checkUserLoging() {
    if (firebaseAuth.currentUser == null || firebaseAuth.currentUser == 0) {
      return false;
    } else {
      return true;
    }
  }
}
