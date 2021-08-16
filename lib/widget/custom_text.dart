import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  String text;
  Color colorText;
  double fontSize;
  FontWeight fontWeight;
  TextDirection textDirection;
  int maxLines;
  TextAlign textAlign;
  String fontFamily;
  FontStyle fontStyle;

  CustomText({
    this.text,
    this.colorText,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.textDirection,
    this.maxLines,
    this.fontStyle,
    this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: colorText,
        fontWeight: fontWeight,
        fontSize: fontSize,
        fontFamily:fontFamily,
        fontStyle:fontStyle,
      ),
      textDirection: textDirection,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}