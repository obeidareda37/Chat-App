import 'package:chat_app/auth/view/home_page.dart';
import 'package:chat_app/auth/view/login_page.dart';
import 'package:chat_app/helpers/auth_helper.dart';
import 'package:chat_app/service/custom_dialog.dart';
import 'package:chat_app/service/routes_helpers.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  resetController() {
    emailController.clear();
    passwordController.clear();
  }

  register() async {
    try {
      await AuthHelper.authHelper
          .signUp(emailController.text, passwordController.text);
      await AuthHelper.authHelper.verifyEmail();
      await AuthHelper.authHelper.logOut();
      RouteHelper.routeHelper.goToPageReplacement(LoginPage.routeName);
    } on Exception catch (e) {
      // TODO
    }
    resetController();
  }

  login() async {
    await AuthHelper.authHelper
        .signIn(emailController.text, passwordController.text);
    bool isVerifiedEmail = AuthHelper.authHelper.checkEmailVerification();
    if (isVerifiedEmail) {
      RouteHelper.routeHelper.goToPageReplacement(HomePage.routeName);
    } else {
      CustomDialog.customDialog.showCustomDialog(
          message:
              'you have to verify your email, press ok to send another email',
          function: sendVerification());
    }
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
