import 'package:chat_app/widget/custom_text.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  Function function;
  String label;
  int activeButton;
  int indexButton;
  bool isClick;
  double width;
  double height;
  Color backgroundColor;

  CustomButton({
    this.function,
    this.label,
    this.activeButton,
    this.indexButton,
    this.width,
    this.height,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: activeButton == indexButton ? Color(0xff1E58B6) : Colors.white,
        border: Border.all(
            color:
                activeButton == indexButton ? Color(0xff1E58B6) : Colors.black,
            width: 1),
      ),
      child: MaterialButton(
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        onPressed: () {
          function();
        },
        child: CustomText(
          text: label,
          colorText: activeButton == indexButton ? Colors.white : Colors.black,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
