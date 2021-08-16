import 'package:flutter/material.dart';

class ImageScreenWidget extends StatelessWidget {
  double width;
  double height;
  double marginTop;
  double marginBottom;
  String image;

  ImageScreenWidget({
    this.width,
    this.height,
    this.marginTop,
    this.marginBottom,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.only(top: marginTop, bottom: marginBottom),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
