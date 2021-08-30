import 'package:chat_app/auth/view/update_profile.dart';
import 'package:chat_app/helpers/shared_pref.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/service/routes_helpers.dart';
import 'package:chat_app/widget/custom_text.dart';
import 'package:chat_app/widget/profile_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
          statusBarColor: Color(0xff1E58B6),
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.grey[200],
          systemNavigationBarIconBrightness: Brightness.dark),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          brightness: Brightness.dark,
          backgroundColor: Color(0xff1E58B6),
          title: CustomText(
            text: 'Profile',
            colorText: Colors.white,
          ),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false)
                    .fillControllers();
                RouteHelper.routeHelper.goToPage(UpdateProfilePage.routeName);
              },
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).logOut();
                SpHelper.spHelper.saveUser(false);
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
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
                    children: [
                      Container(
                        padding: EdgeInsets.all(40),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xff1E58B6),
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 84,
                          child: CircleAvatar(
                            radius: 80,
                            backgroundImage:
                                NetworkImage(provider.user.imageUrl),
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(0,-20),
                        child: Container(

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),

                            ),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              ProfileItemWidget('Email', provider.user.email),
                              ProfileItemWidget('Full Name', provider.user.fname),
                              ProfileItemWidget(
                                  'Country Name', provider.user.country),
                              ProfileItemWidget('Ciry Name', provider.user.city),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}
