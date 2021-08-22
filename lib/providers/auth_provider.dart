import 'package:chat_app/auth/view/home_page.dart';
import 'package:chat_app/auth/view/login_page.dart';
import 'package:chat_app/helpers/auth_helper.dart';
import 'package:chat_app/helpers/firebase_helper.dart';
import 'package:chat_app/helpers/shared_pref.dart';
import 'package:chat_app/models/register_request.dart';
import 'package:chat_app/service/custom_dialog.dart';
import 'package:chat_app/service/routes_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  resetController() {
    emailController.clear();
    passwordController.clear();
    fNameController.clear();
    lNameController.clear();
    countryController.clear();
    cityController.clear();
  }

  register() async {
    try {
      UserCredential userCredential = await AuthHelper.authHelper
          .signUp(emailController.text, passwordController.text);
      RegisterRequest registerRequest = RegisterRequest(
        id: userCredential.user.uid,
        fname: fNameController.text,
        lname: lNameController.text,
        city: cityController.text,
        country: countryController.text,
        email: emailController.text,
        password: passwordController.text,
      );
      await FirebaseHelpers.firebaseHelpers.addUserToFirestore(registerRequest);
      await AuthHelper.authHelper.verifyEmail();
      await AuthHelper.authHelper.logOut();
      RouteHelper.routeHelper.goToPageReplacement(LoginPage.routeName);
    } on Exception catch (e) {
      // TODO
    }
    resetController();
  }

  login() async {
    UserCredential userCredential = await AuthHelper.authHelper
        .signIn(emailController.text, passwordController.text);
    SpHelper.spHelper.saveUser(true);

    // bool isVerifiedEmail = AuthHelper.authHelper.checkEmailVerification();
    // if (isVerifiedEmail) {
    FirebaseHelpers.firebaseHelpers.getUserFromFirestore(userCredential.user.uid);
      RouteHelper.routeHelper.goToPageReplacement(HomePage.routeName);
    // } else {
    //   CustomDialog.customDialog.showCustomDialog(
    //     message:
    //         'you have to verify your email, press ok to send another email',
    //     function: sendVerification(),
    //   );
    // }
    resetController();
  }

  resetPassword() async {
    AuthHelper.authHelper.resetPassword(emailController.text);
    RouteHelper.routeHelper.goToPageReplacement(LoginPage.routeName);

    resetController();
  }

  sendVerification() async {
    AuthHelper.authHelper.verifyEmail();
    AuthHelper.authHelper.logOut();
  }
}
