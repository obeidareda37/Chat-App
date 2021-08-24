import 'package:chat_app/helpers/firebase_helper.dart';
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
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
            itemCount: usermodels.length,
            itemBuilder: (context, index) {
              return Text(usermodels[index].email);
            }),
        //child: Container(child: Center(child: Text('home')),),
        //     child: FutureBuilder<List<UserModel>>(
        //   future: FirebaseHelpers.firebaseHelpers.getAllUsersFromFirestore(),
        //   builder: (context, snapShot) {
        //     if (snapShot.connectionState == ConnectionState.waiting) {
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     } else {
        //       usermodels = snapShot.data;
        //       return ListView(
        //         children: usermodels.map((e) => Text(e.email)).toList(),
        //       );
        //     }
        //   },
        // )),
      ),
    );
  }
}
