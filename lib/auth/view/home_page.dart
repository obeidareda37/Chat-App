import 'package:chat_app/auth/view/profile_page.dart';
import 'package:chat_app/auth/view/user_page.dart';
import 'package:chat_app/helpers/firestore_helper.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static final routeName = 'home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserModel userModel;

  List<UserModel> usermodels = List<UserModel>();

  get() async {
    usermodels =
        await FirebaseHelpers.firebaseHelpers.getAllUsersFromFirestore();
    print('${usermodels.length}  users ');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }

  @override
  Widget build(BuildContext context) {
    get();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: TabBarView(
          children: [UserPage(), ProfilePage()],
        ),
      ),
    );
  }
}
