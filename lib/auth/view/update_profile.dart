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
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Update Profile'),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<AuthProvider>(context,listen: false).updateProfile();
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
                SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    provider.captureUpdateProfileImage();
                  },
                  child: provider.updateFile == null
                      ? CircleAvatar(
                          radius: 80,
                          backgroundImage: NetworkImage(provider.user.imageUrl),
                        )
                      : CircleAvatar(
                          radius: 80,
                          backgroundImage: FileImage(provider.updateFile),
                        ),
                ),
                UpdateProfileItemWidget('Full Name', provider.fNameController),
                UpdateProfileItemWidget(
                    'Country Name', provider.countryController),
                UpdateProfileItemWidget('City Name', provider.cityController),
              ],
            ),
          );
        },
      ),
    );
  }
}
