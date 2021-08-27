import 'package:chat_app/auth/view/update_profile.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/service/routes_helpers.dart';
import 'package:chat_app/widget/profile_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  static final routeName = 'profile';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AuthProvider>(context, listen: false).getUserFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false)
                  .fillControllers();
              RouteHelper.routeHelper.goToPage(UpdateProfilePage.routeName);
            },
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logOut();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Consumer<AuthProvider>(
        builder: (context, provider, x) {
          return provider.user == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: NetworkImage(provider.user.imageUrl),
                    ),
                    ProfileItemWidget('Email', provider.user.email),
                    ProfileItemWidget('First Name', provider.user.fName),
                    ProfileItemWidget('last Name', provider.user.lName),
                    ProfileItemWidget('Country Name', provider.user.country),
                    ProfileItemWidget('Ciry Name', provider.user.city),
                  ],
                );
        },
      ),
    );
  }
}
