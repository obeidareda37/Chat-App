import 'package:chat_app/widget/custom_icon.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationChatState extends StatelessWidget {
  TextEditingController chatController;
  String Function(String x) onChange;
  Function onTapSend;


  CustomBottomNavigationChatState(
      {this.chatController, this.onChange, this.onTapSend});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xff1E58B6),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Container(
            margin: EdgeInsets.only(right: 20),
            child: CustomIcon(
              image: 'assets/icons/send.svg',
              width: 24,
              height: 23,
              onTap: onTapSend,
            ),
          ),
          SizedBox(
            width: 25,
          ),
          Expanded(
            child: Container(
              width: 305,
              child: TextFormField(
                onChanged: onChange,
                controller: chatController,
                decoration: InputDecoration(
                  hintText: 'Enter a message',
                  contentPadding: EdgeInsets.only(
                    top: 10,
                    left: 15,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
