import 'package:chat_app/auth/view/register_page.dart';
import 'package:chat_app/auth/view/rest_password.dart';
import 'package:chat_app/helpers/shared_pref.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/service/routes_helpers.dart';
import 'package:chat_app/widget/custom_button.dart';
import 'package:chat_app/widget/custom_icon.dart';
import 'package:chat_app/widget/custom_text.dart';
import 'package:chat_app/widget/custom_text_field.dart';
import 'package:chat_app/widget/custom_text_password_field.dart';
import 'package:chat_app/widget/image_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static final routeName = 'login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController controller = TextEditingController();

  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<AuthProvider>(
          builder: (context, provider, x) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Center(
                      child: CustomText(
                        text: 'Welcome Back!',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ImageScreenWidget(
                    image: 'assets/images/login.jpg',
                    width: double.infinity,
                    height: 350,
                    marginBottom: 10,
                    marginTop: 1,
                  ),
                  CustomTextField(
                    textInputType: TextInputType.emailAddress,
                    controller: provider.emailController,
                    hint: 'Email',
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextPasswordField(
                    textInputType: TextInputType.visiblePassword,
                    controller: provider.passwordController,
                    hint: 'password',
                    prefixIcon: Icon(
                      Icons.lock_open_outlined,
                      color: Colors.grey,
                    ),
                    obscureText: obscureText,
                    onTap: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      RouteHelper.routeHelper.goToPage(ResetPassword.routeName);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 25),
                      alignment: Alignment.centerRight,
                      child: CustomText(
                        text: 'Forget Password',
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        colorText: Color(0xff1E58B6),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    backgroundColor: Color(0xff1E58B6),
                    height: 50,
                    width: 220,
                    label: 'Login',
                    function: () {
                      provider.login();
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIcon(
                        image: 'assets/icons/facebook.svg',
                        width: 40,
                        height: 40,
                        onTap: () {},
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      CustomIcon(
                        image: 'assets/icons/google-plus.svg',
                        width: 40,
                        height: 40,
                        onTap: () {},
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: 'Dont\'t have an account?',
                        colorText: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      GestureDetector(
                        onTap: () {
                          RouteHelper.routeHelper
                              .goToPage(RegisterPage.routeName);
                        },
                        child: CustomText(
                          text: 'Sign up',
                          colorText: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
