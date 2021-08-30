import 'package:chat_app/main.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/widget/profile_item_widget.dart';
import 'package:chat_app/widget/update_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateProfilePage extends StatefulWidget {
  static final routeName = 'UpdateProfile';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<UpdateProfilePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff1E58B6),
        title: Text('Update Profile'),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).updateProfile();
            },
            icon: Icon(Icons.done),
          ),
        ],
      ),
      body: Consumer<AuthProvider>(
        builder: (context, provider, x) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(40),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xff1E58B6),
                      ),
                      child: provider.updateFile == null
                          ? CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 84,
                              child: CircleAvatar(
                                radius: 80,
                                backgroundImage:
                                    NetworkImage(provider.user.imageUrl),
                              ),
                            )
                          : CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 84,
                              child: CircleAvatar(
                                radius: 80,
                                backgroundImage: FileImage(provider.updateFile),
                              ),
                            ),
                    ),
                    Positioned(
                      bottom: 52.0,
                      right: 120.0,
                      child: InkWell(
                        onTap: () {
                          provider.captureUpdateProfileImage();
                        },
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.blueGrey,
                          size: 28.0,
                        ),
                      ),
                    ),
                  ],
                ),
                Transform.translate(
                  offset: Offset(0,-20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        topLeft: Radius.circular(25),
                      ),
                    ),
                    child: Column(
                      children: [
                        UpdateProfileItemWidget(
                            'Full Name', provider.fNameController),
                        UpdateProfileItemWidget(
                            'Country Name', provider.countryController),
                        UpdateProfileItemWidget(
                            'City Name', provider.cityController),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
