import 'package:chat_app/auth/view/group_chat.dart';
import 'package:chat_app/auth/view/profile_page.dart';
import 'package:chat_app/auth/view/user_page.dart';
import 'package:chat_app/helpers/firestore_helper.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/service/routes_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }

  List<Widget> screens = [
    ProfilePage(),
    GroupChatPage(),
    UserPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white
      ),
      child: Scaffold(

        bottomNavigationBar: index == 1
            ? null
            : BottomNavigationBar(
          backgroundColor: Colors.white,

                selectedItemColor: Color(0xff1E58B6),
                currentIndex: index,
                onTap: (x) {
                  setState(() {
                    index = x;
                  });
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person_outline), label: 'profile'),
                  BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'chats'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person_outline_sharp), label: 'Users'),
                ],
              ),
        body: screens.elementAt(index),
      ),
    );
  }
}
