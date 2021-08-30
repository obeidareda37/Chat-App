import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomChatBetweenTwoClient extends StatelessWidget {
  String image;
  String message;
  String name;
  Color color;
  Offset offset;
  bool right;
  TextDirection textDirection;

  CustomChatBetweenTwoClient({
    this.image,
    this.message,
    this.color,
    this.name,
    this.offset,
    this.right = false,
    this.textDirection,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 286,
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            textDirection: textDirection,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(image),
              ),
              SizedBox(
                width: 10,
              ),
              CustomText(
                text: name,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                colorText: right ? Colors.redAccent : Colors.blueAccent,
              ),
            ],
          ),
          Container(
            margin: EdgeInsetsDirectional.only(start: 40),
            transform: Matrix4.translationValues(0, -5, 0),
            width: 248,
            child: Card(
              color: color,
              shape: RoundedRectangleBorder(
                borderRadius: right
                    ? BorderRadius.only(
                        topLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                        bottomLeft: Radius.circular(25),
                      )
                    : BorderRadius.only(
                        topRight: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                        bottomLeft: Radius.circular(25),
                      ),
              ),
              elevation: 2,
              child: Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.only(left: 5, right: 5),
                child: CustomText(
                  text: message,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  colorText: right ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
