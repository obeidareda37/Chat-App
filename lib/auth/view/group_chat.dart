import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:chat_app/auth/view/home_page.dart';
import 'package:chat_app/helpers/auth_helper.dart';
import 'package:chat_app/helpers/firestore_helper.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/service/routes_helpers.dart';
import 'package:chat_app/widget/custom_icon.dart';
import 'package:chat_app/widget/custom_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_5.dart';
import 'package:record_mp3/record_mp3.dart';

class GroupChatPage extends StatefulWidget {
  static final routeName = 'Group';

  @override
  _GroupChatPageState createState() => _GroupChatPageState();
}

class _GroupChatPageState extends State<GroupChatPage> {
  TextEditingController textEditingController = TextEditingController();
  String message;
  TextEditingController _tec = TextEditingController();
  bool isPlayingMsg = false, isRecording = false, isSending = false;
  String audio;

  sendToFirestore() async {
    textEditingController.clear();
    FirebaseHelpers.firebaseHelpers.addMessageToFirbaseFirestore({
      'message': this.message,
      'dateTime': DateTime.now(),
      'audio': this.audio,
    });
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
                                                  maxWidth: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.7),
                                              child: messages[index]
                                                              ['imageUrl'] ==
                                                          null &&
                                                      messages[index]
                                                              ['message'] !=
                                                          null
                                                  ? Text(messages[index]['message'],
                                                      style: TextStyle(
                                                          color: Colors.white))
                                                  : messages[index]['audio'] != null &&
                                                          messages[index]
                                                                  ['message'] ==
                                                              null &&
                                                          messages[index]
                                                              ['imageUrl']
                                                      ? Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.5,
                                                          padding:
                                                              EdgeInsets.all(8),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: isMe
                                                                ? Colors
                                                                    .greenAccent
                                                                : Colors
                                                                    .orangeAccent,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child:
                                                              GestureDetector(
                                                                  onTap: () {
                                                                    _loadFile(messages[
                                                                            index]
                                                                        [
                                                                        'audio']);
                                                                    setState(
                                                                        () {
                                                                      isSending =
                                                                          false;
                                                                    });
                                                                  },
                                                                  onSecondaryTap:
                                                                      () {
                                                                    stopRecord();
                                                                  },
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          Icon(isPlayingMsg
                                                                              ? Icons.cancel
                                                                              : Icons.play_arrow),
                                                                          Text(
                                                                            'Audio-${messages[index]['dateTime']}',
                                                                            maxLines:
                                                                                10,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      // Text(
                                                                      //   date + " " + hour.toString() + ":" + min.toString() + ampm,
                                                                      //   style: TextStyle(fontSize: 10),
                                                                      // )
                                                                    ],
                                                                  )),
                                                        )
                                                      : Image.network(messages[index]['imageUrl'])),
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
                                IconButton(
                                    onPressed: () {
                                      sendToFirestore();
                                    },
                                    icon: Icon(Icons.play_arrow)),
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

  // sendAudioMsg(String audioMsg) async {
  //   if (audioMsg.isNotEmpty) {
  //     var ref = FirebaseFirestore.instance
  //         .collection('Chats')
  //         .doc(Provider.of<AuthProvider>(context).myId);
  //     await FirebaseFirestore.instance.runTransaction((transaction) async {
  //       await transaction.set(ref, {
  //         "senderId": Provider.of<AuthProvider>(context).myId,
  //         "anotherUserId": widget.docs['id'],
  //         "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
  //         "content": audioMsg,
  //         "type": 'audio'
  //       });
  //     }).then((value) {
  //       setState(() {
  //         isSending = false;
  //       });
  //     });
  //     scrollController.animateTo(0.0,
  //         duration: Duration(milliseconds: 100), curve: Curves.bounceInOut);
  //   } else {
  //     print("Hello");
  //   }
  // }

  // buildItem(doc) {
  //   print("MSG " + doc['content']);
  //   var day = DateTime.fromMillisecondsSinceEpoch(int.parse(doc['timestamp']))
  //       .day
  //       .toString();
  //   var month = DateTime.fromMillisecondsSinceEpoch(int.parse(doc['timestamp']))
  //       .month
  //       .toString();
  //   var year = DateTime.fromMillisecondsSinceEpoch(int.parse(doc['timestamp']))
  //       .year
  //       .toString()
  //       .substring(2);
  //   var date = day + '-' + month + '-' + year;
  //   var hour =
  //       DateTime.fromMillisecondsSinceEpoch(int.parse(doc['timestamp'])).hour;
  //   var min =
  //       DateTime.fromMillisecondsSinceEpoch(int.parse(doc['timestamp'])).minute;
  //   var ampm;
  //   if (hour > 12) {
  //     hour = hour % 12;
  //     ampm = 'pm';
  //   } else if (hour == 12) {
  //     ampm = 'pm';
  //   } else if (hour == 0) {
  //     hour = 12;
  //     ampm = 'am';
  //   } else {
  //     ampm = 'am';
  //   }
  //   if (doc['type'].toString() == 'audio') {
  //     return Padding(
  //       padding: EdgeInsets.only(
  //           top: 8,
  //
  //       child: Container(
  //         width: MediaQuery.of(context).size.width * 0.5,
  //         padding: EdgeInsets.all(8),
  //         decoration: BoxDecoration(
  //           color: (doc['senderId'] == userID)
  //               ? Colors.greenAccent
  //               : Colors.orangeAccent,
  //           borderRadius: BorderRadius.circular(10),
  //         ),
  //         child: GestureDetector(
  //             onTap: () {
  //               _loadFile(doc['audio']);
  //             },
  //             onSecondaryTap: () {
  //               stopRecord();
  //             },
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               crossAxisAlignment: CrossAxisAlignment.end,
  //               children: [
  //                 Row(
  //                   children: [
  //                     Icon(isPlayingMsg ? Icons.cancel : Icons.play_arrow),
  //                     Text(
  //                       'Audio-${doc['dateTime']}',
  //                       maxLines: 10,
  //                     ),
  //                   ],
  //                 ),
  //                 // Text(
  //                 //   date + " " + hour.toString() + ":" + min.toString() + ampm,
  //                 //   style: TextStyle(fontSize: 10),
  //                 // )
  //               ],
  //             )),
  //       ),
  //     );
  //   } else {
  //     return Padding(
  //       padding: EdgeInsets.only(
  //           top: 8,
  //           left: ((doc['senderId'] == userID) ? 64 : 10),
  //           right: ((doc['senderId'] == userID) ? 10 : 64)),
  //       child: Container(
  //         width: MediaQuery.of(context).size.width * 0.5,
  //         padding: EdgeInsets.all(8),
  //         decoration: BoxDecoration(
  //           color: (doc['senderId'] == userID)
  //               ? Colors.greenAccent
  //               : Colors.orangeAccent,
  //           borderRadius: BorderRadius.circular(10),
  //         ),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           crossAxisAlignment: CrossAxisAlignment.end,
  //           children: [
  //             Text(doc['audio'] + "\n"),
  //             Text(
  //               date + " " + hour.toString() + ":" + min.toString() + ampm,
  //               style: TextStyle(fontSize: 10),
  //             )
  //           ],
  //         ),
  //       ),
  //     );
  //   }
  // }

  Future _loadFile(String url) async {
    final bytes = await readBytes(Uri.parse(url));
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/audio.mp3');

    await file.writeAsBytes(bytes);
    if (await file.exists()) {
      setState(() {
        recordFilePath = file.path;
        isPlayingMsg = true;
        print(isPlayingMsg);
      });
      await play();
      setState(() {
        isPlayingMsg = false;
        print(isPlayingMsg);
      });
    }
  }

  Future<bool> checkPermission() async {
    if (!await Permission.microphone.isGranted) {
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  void startRecord() async {
    bool hasPermission = await checkPermission();
    if (hasPermission) {
      recordFilePath = await getFilePath();

      RecordMp3.instance.start(recordFilePath, (type) {
        setState(() {});
      });
    } else {}
    setState(() {});
  }

  void stopRecord() async {
    bool s = RecordMp3.instance.stop();
    if (s) {
      setState(() {
        isSending = true;
      });
      await uploadAudio();

      setState(() {
        isPlayingMsg = false;
      });
    }
  }

  String recordFilePath;

  Future<void> play() async {
    if (recordFilePath != null && File(recordFilePath).existsSync()) {
      AudioPlayer audioPlayer = AudioPlayer();
      await audioPlayer.play(
        recordFilePath,
        isLocal: true,
      );
    }
  }

  int i = 0;

  Future<String> getFilePath() async {
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath = storageDirectory.path + "/record";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    return sdPath + "/test_${i++}.mp3";
  }

  uploadAudio() async {
    Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(
        'profilepics/audio${DateTime.now().millisecondsSinceEpoch.toString()}}.jpg');

    await firebaseStorageRef.putFile(File(recordFilePath));

    print('##############done#########');
    var audioURL = await firebaseStorageRef.getDownloadURL();
    audio = audioURL.toString();
  }
}
