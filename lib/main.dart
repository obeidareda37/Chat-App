import 'package:chat_app/auth/view/home_page.dart';
import 'package:chat_app/auth/view/login_page.dart';
import 'package:chat_app/auth/view/rest_password.dart';
import 'package:chat_app/auth/view/register_page.dart';
import 'package:chat_app/auth/view/welcome_page.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/service/routes_helpers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider<AuthProvider>(
      create: (context)=> AuthProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          LoginPage.routeName:(context)=>LoginPage(),
          RegisterPage.routeName:(context)=>RegisterPage(),
          ResetPassword.routeName:(context)=>ResetPassword(),
          HomePage.routeName:(context)=>HomePage(),
        },
        navigatorKey: RouteHelper.routeHelper.navKey,
        home: App(),
      ),
    ),
  );
}

class App extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: Colors.red,
            body: Center(
              child: Text(snapshot.error.toString()),
            ),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return WelcomePage();
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
        // // Otherwise, show something whilst waiting for initialization to complete
        // return Loading();
      },
    );
  }
}
