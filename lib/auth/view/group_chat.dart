import 'package:chat_app/auth/view/home_page.dart';
import 'package:chat_app/helpers/firestore_helper.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/service/routes_helpers.dart';
import 'package:chat_app/widget/custom_bottom_navigation_chat.dart';
import 'package:chat_app/widget/custom_chat.dart';
import 'package:chat_app/widget/custom_icon.dart';
import 'package:chat_app/widget/custom_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class GroupChatPage extends StatefulWidget {
  static final routeName = 'Group';

  @override
  _GroupChatPageState createState() => _GroupChatPageState();
}

class _GroupChatPageState extends State<GroupChatPage> {
  TextEditingController messageController = TextEditingController();
  String message;
  List<Map> Message;

  sendTofirestore() async {
    FirebaseHelpers.firebaseHelpers.addMessageToFirbaseFirestore({
      'message': messageController.text,
      'dateTime': DateTime.now(),
      'imageUrl':
          Provider.of<AuthProvider>(context, listen: false).user.imageUrl,
      'fname': Provider.of<AuthProvider>(context, listen: false).user.fname,
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Color(0xff1E58B6),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        // bottomNavigationBar: CustomBottomNavigationChatState(
        //   chatController: messageController,
        //   onTapSend: () {
        //     sendTofirestore();
        //     messageController.clear();
        //   },
        // ),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          leading: IconButton(
              onPressed: () {
                RouteHelper.routeHelper.goToPageReplacement(HomePage.routeName);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Color(0xff1E58B6),
              )),
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
                    child: SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20, top: 10),
                        child:
                            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: FirebaseHelpers.firebaseHelpers
                              .getFirestoreStrem(),
                          builder: (context, datasnapshot) {
                            if (!datasnapshot.hasData) {
                              return Center(child: CircularProgressIndicator());
                            }
                            QuerySnapshot<Map<String, dynamic>> querySnapShot =
                                datasnapshot.data;
                            Message = querySnapShot.docs
                                .map((e) => e.data())
                                .toList();

                            return Message == null
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Message[index]['userId'] ==
                                              provider.myId
                                          ? Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: CustomChatBetweenTwoClient(
                                                color: Color(0xff2978F6),
                                                right: true,
                                                message: Message[index]
                                                    ['message'],
                                                image: Message[index]
                                                        ['imageUrl'] ??
                                                    'https://i.pinimg.com/originals/70/c7/af/70c7afacdfb4016f786753f9e5071fc4.jpg',
                                                name: Message[index]['fname'] ??
                                                    'Guest',
                                              ),
                                            )
                                          : Directionality(
                                              textDirection: TextDirection.ltr,
                                              child: CustomChatBetweenTwoClient(
                                                textDirection:
                                                    TextDirection.ltr,
                                                right: false,
                                                color: Color(0xffE4E4E4),
                                                message: Message[index]
                                                    ['message'],
                                                image: Message[index]
                                                        ['imageUrl'] ??
                                                    'https://i.pinimg.com/originals/70/c7/af/70c7afacdfb4016f786753f9e5071fc4.jpg',
                                                name: Message[index]['fname'] ??
                                                    'Guest',
                                              ),
                                            );
                                    },
                                    itemCount: Message.length,
                                  );
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Color(0xff1E58B6),
                    width: double.infinity,
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            child: TextFormField(
                              maxLines: 10,
                              minLines: 1,
                              controller: messageController,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.start,
                              onChanged: (x) {},
                              decoration: InputDecoration(
                                  hintText: 'Enter a message',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15))),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: CustomIcon(
                            image: 'assets/icons/send.svg',
                            width: 24,
                            height: 23,
                            onTap: () {
                              sendTofirestore();
                              messageController.clear();
                            },
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
      ),
    );
  }
}
