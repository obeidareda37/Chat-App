import 'package:chat_app/main.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserPage extends StatelessWidget {
  static final routeName = 'userPAge';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('All User'),
        ),
        body: Consumer<AuthProvider>(
          builder: (context, provider, x) {
            if (provider.users == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                  itemCount: provider.users.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                NetworkImage(provider.users[index].imageUrl),
                          ),

                          SizedBox(width: 20,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(provider.users[index].fname),
                              Text(provider.users[index].email),
                              Text(
                                provider.users[index].country +
                                    ' - ' +
                                    provider.users[index].city,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  });
            }
          },
        ));
  }
}
