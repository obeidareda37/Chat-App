import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomIcon extends StatelessWidget {

  double width;
  double height;
  String image;
  Function onTap;

  CustomIcon({
    this.width,
    this.height,
    this.image,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        child: SvgPicture.asset(
          image,
          width: width,
          height: height,
        ),

      ),
    );
  }
}