import 'package:chat_app/main.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  static final routeName = 'userPAge';

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AuthProvider>(context, listen: false).getAllUserFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.white,
        systemNavigationBarColor: Color(0xff1E58B6),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            brightness: Brightness.dark,
            centerTitle: true,
            backgroundColor: Colors.grey[100],
            title: CustomText(
              text: 'All Users',
              colorText: Color(0xff1E58B6),
            ),
            elevation: 0,
          ),
          body: Consumer<AuthProvider>(
            builder: (context, provider, x) {
              if (provider.users == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 25),
                  child: ListView.builder(
                      itemCount: provider.users.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Color(0xff1E58B6),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 3,
                          child: Container(
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(15),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 43,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundImage: NetworkImage(
                                        provider.users[index].imageUrl),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Full Name : ${provider.users[index].fname}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      'Email Address : ${provider.users[index].email}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      'Address : ${provider.users[index].country + ' - ' + provider.users[index].city}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                );
              }
            },
          )),
    );
  }
}
