import 'package:chat_app/auth/helpers/auth_helper.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider extends ChangeNotifier{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  register()async{
    AuthHelper.authHelper.signUp(emailController.text, passwordController.text);
  }

}