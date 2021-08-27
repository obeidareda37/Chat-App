import 'package:flutter/material.dart';

class UpdateProfileItemWidget extends StatelessWidget {
  String lable;
  TextEditingController controller;

  UpdateProfileItemWidget(this.lable, this.controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            lable,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: TextField(
              controller: controller,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          )
        ],
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
