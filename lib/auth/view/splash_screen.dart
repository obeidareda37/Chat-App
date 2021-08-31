import 'package:chat_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static final routName = 'SplashScreen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Future.delayed(Duration(seconds: 2)).then((value) =>
    //     Provider.of<AuthProvider>(context, listen: false).checkLogin());
    Future.delayed(Duration(seconds: 2)).then((value) =>
        Provider.of<AuthProvider>(context, listen: false).checkLogin());
  }

  // firstTime() async {
  //   if (await SpHelper.spHelper.getUser() == false) {
  //     RouteHelper.routeHelper.goToPageReplacement(WelcomePage.routeName);
  //   }
  //   if (await SpHelper.spHelper.getUser() != true) {
  //     RouteHelper.routeHelper.goToPageReplacement(HomePage.routeName);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage('assets/images/splash2.png'),
          ),
        ),
      ),
    );
  }
}
