import 'package:flutter/material.dart';

class CustomTextPasswordField extends StatelessWidget {
  String hint;
  TextEditingController controller;
  Icon prefixIcon;
  Icon suffixIcon;
  bool obscureText;
  Function onTap;
  TextInputType textInputType;

  CustomTextPasswordField({
    this.hint,
    this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.obscureText,
    this.onTap,
    this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        keyboardType: textInputType,
        obscureText: obscureText,
        controller: this.controller,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: prefixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          suffixIcon: InkWell(
            onTap: onTap,
            child: Icon(obscureText?Icons.visibility:Icons.visibility_off,
            color: Colors.grey,),
        ),
      ),
    ),);
  }
}
