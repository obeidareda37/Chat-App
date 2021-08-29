import 'package:chat_app/helpers/firestore_helper.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupChatPage extends StatelessWidget {
  static final routeName = 'Group';
  String message;

  sendTofirestore() async {
    FirebaseHelpers.firebaseHelpers.addMessageToFirbaseFirestore({
      'message': this.message,
      'dateTime': DateTime.now(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Group Chat'),
      ),
      body: Consumer<AuthProvider>(
        builder: (context, provider, x) {
          return Container(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream:
                          FirebaseHelpers.firebaseHelpers.getFirestoreStrem(),
                      builder: (context, datasnapshot) {
                        QuerySnapshot<Map<String, dynamic>> querySnapShot =
                            datasnapshot.data;
                        List<Map> message =
                            querySnapShot.docs.map((e) => e.data()).toList();
                        return ListView.builder(itemBuilder: (context,index){
                          return Text(message[index]['message'],);
                        },itemCount: message.length,);
                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                        onChanged: (x) {
                          this.message = x;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      )),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(5),
                        child: IconButton(
                          onPressed: () {
                            sendTofirestore();
                          },
                          icon: Icon(Icons.send),
                        ),
                      ),
                    ],
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
