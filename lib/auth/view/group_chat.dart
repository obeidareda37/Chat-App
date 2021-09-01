import 'package:chat_app/auth/view/home_page.dart';
import 'package:chat_app/helpers/auth_helper.dart';
import 'package:chat_app/helpers/firestore_helper.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/service/routes_helpers.dart';
import 'package:chat_app/widget/custom_icon.dart';
import 'package:chat_app/widget/custom_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_5.dart';

class GroupChatPage extends StatefulWidget {
  static final routeName = 'Group';

  @override
  _GroupChatPageState createState() => _GroupChatPageState();
}

class _GroupChatPageState extends State<GroupChatPage> {
  TextEditingController textEditingController = TextEditingController();
  String message;

  sendToFirestore() async {
    textEditingController.clear();
    FirebaseHelpers.firebaseHelpers.addMessageToFirbaseFirestore(
        {'message': this.message, 'dateTime': DateTime.now()});
  }

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.grey[200],
      ),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          leading: IconButton(
            onPressed: () {
              RouteHelper.routeHelper.goToPageReplacement(HomePage.routeName);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xff1E58B6),
            ),
          ),
          actions: [
            PopupMenuButton(
                onSelected: (item) => onSelected(context, item),
                itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 0,
                        child: CustomText(
                          text: 'Profile',
                        ),
                      ),
                      PopupMenuItem(
                        value: 1,
                        child: CustomText(
                          text: 'Clear Chat',
                        ),
                      ),
                      PopupMenuItem(
                        value: 2,
                        child: CustomText(
                          text: 'LogOut',
                        ),
                      ),
                    ]),
          ],
          automaticallyImplyLeading: true,
          title: CustomText(
            text: 'Group Chat',
            colorText: Color(0xff1E58B6),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
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
                          if (!datasnapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }
                          Future.delayed(Duration(seconds: 1)).then((value) {
                            scrollController.animateTo(
                                scrollController.position.maxScrollExtent,
                                duration: Duration(milliseconds: 100),
                                curve: Curves.easeInOut);
                          });
                          QuerySnapshot<Map<String, dynamic>> querySnapshot =
                              datasnapshot.data;
                          List<Map> messages =
                              querySnapshot.docs.map((e) => e.data()).toList();
                          return ListView.builder(
                              shrinkWrap: true,
                              controller: scrollController,
                              itemCount: messages.length,
                              itemBuilder: (context, index) {
                                bool isMe =
                                    messages[index]['userId'] == provider.myId;
                                return isMe
                                    ? Container(
                                        child: ChatBubble(
                                          shadowColor: Colors.transparent,
                                          alignment: Alignment.topRight,
                                          margin: EdgeInsets.only(
                                              top: 20, right: 20, bottom: 10),
                                          backGroundColor: messages[index]
                                                      ['imageUrl'] ==
                                                  null
                                              ? Colors.blue
                                              : Colors.transparent
                                                  .withOpacity(0),
                                          child: Container(
                                              constraints: BoxConstraints(
                                                  maxWidth:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.7),
                                              child: messages[index]
                                                          ['imageUrl'] ==
                                                      null
                                                  ? Text(
                                                      messages[index]
                                                          ['message'],
                                                      style: TextStyle(
                                                          color: Colors.white))
                                                  : Image.network(
                                                      messages[index]
                                                          ['imageUrl'])),
                                          clipper: ChatBubbleClipper5(
                                              type: BubbleType.sendBubble),
                                        ),
                                      )
                                    : ChatBubble(
                                        backGroundColor: Color(0xffE7E7ED),
                                        margin: EdgeInsets.only(
                                            top: 20, left: 20, bottom: 10),
                                        child: Container(
                                            constraints: BoxConstraints(
                                              maxWidth: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.7,
                                            ),
                                            child: messages[index]
                                                        ['imageUrl'] ==
                                                    null
                                                ? Text(
                                                    messages[index]['message'],
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  )
                                                : Image.network(messages[index]
                                                    ['imageUrl'])),
                                        clipper: ChatBubbleClipper5(
                                            type: BubbleType.receiverBubble),
                                      );
                              });
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      provider.sendImageToChat();
                                    },
                                    icon: Icon(Icons.attach_file)),
                                Expanded(
                                    child: TextField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none)),
                                  controller: textEditingController,
                                  onChanged: (x) {
                                    this.message = x;
                                  },
                                )),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xff1E58B6),
                              borderRadius: BorderRadius.circular(15)),
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.all(5),
                          child: CustomIcon(
                            image: 'assets/icons/send.svg',
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  onSelected(BuildContext context, item) async {
    switch (item) {
      case 0:
        print('Profile Clicked');
        RouteHelper.routeHelper.goToPageReplacement(HomePage.routeName);
        break;
      case 1:
        print('Clear Chat');
        await FirebaseHelpers.firebaseHelpers.deleteAllChat();
        break;
      case 2:
        print('LogOut');
        AuthHelper.authHelper.logOut();
        break;
    }
  }
}
