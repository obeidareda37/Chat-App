import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  String hint;
  TextEditingController controller;
  Icon prefixIcon;
  Icon suffixIcon;
  TextInputType textInputType;
  Function onChange;
  Function(String value) validate;

  CustomTextField({
    this.hint,
    this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.textInputType,
    this.onChange,
    this.validate
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        validator:validate ,
        keyboardType: textInputType,
        controller: this.controller,
        onChanged: onChange,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          hintText: hint,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
