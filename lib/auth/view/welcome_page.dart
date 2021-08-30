import 'package:chat_app/auth/view/login_page.dart';
import 'package:chat_app/auth/view/register_page.dart';
import 'package:chat_app/service/routes_helpers.dart';
import 'package:chat_app/widget/custom_button.dart';
import 'package:chat_app/widget/custom_icon.dart';
import 'package:chat_app/widget/custom_text.dart';
import 'package:chat_app/widget/image_screen_widget.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  static final routeName = 'welcome';

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int activeButton = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            ImageScreenWidget(
              image: 'assets/images/welcome.png',
              width: double.infinity,
              height: 350,
              marginTop: 40,
              marginBottom: 10,
            ),
            CustomText(
              text: 'Welcome',
              colorText: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: 350,
              child: CustomText(
                text:
                    'App allows to take pictures of your receipts and save the receipts information',
                fontSize: 15,
                fontWeight: FontWeight.w300,
                colorText: Colors.black,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  width: 130,
                  height: 40,
                  label: 'Login',
                  activeButton: activeButton,
                  indexButton: 1,
                  function: () {
                    setState(
                      () {
                        activeButton = 1;
                        RouteHelper.routeHelper
                            .goToPageReplacement(LoginPage.routeName);
                      },
                    );
                  },
                ),
                SizedBox(
                  width: 30,
                ),
                CustomButton(
                  width: 130,
                  height: 40,
                  label: 'Sign Up',
                  activeButton: activeButton,
                  indexButton: 2,
                  function: () {
                    setState(
                      () {
                        activeButton = 2;
                        RouteHelper.routeHelper
                            .goToPageReplacement(RegisterPage.routeName);
                      },
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            CustomText(
              text: 'Or via social media',
              colorText: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomIcon(
                  image: 'assets/icons/facebook.svg',
                  width: 35,
                  height: 35,
                  onTap: () {},
                ),
                SizedBox(
                  width: 12,
                ),
                CustomIcon(
                  image: 'assets/icons/google-plus.svg',
                  width: 35,
                  height: 35,
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
