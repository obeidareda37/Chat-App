import 'package:flutter/material.dart';

class UserModel {
  String id;
  String email;
  String city;
  String country;
  String fName;
  String lName;
  String imageUrl;

  UserModel({
    @required this.id,
    @required this.email,
    @required this.city,
    @required this.country,
    @required this.fName,
    @required this.lName,
    @required this.imageUrl,
  });

  UserModel.fromMap(Map map) {
    this.id = map['id'];
    this.email = map['email'];
    this.city = map['city'];
    this.country = map['country'];
    this.fName = map['fname'];
    this.lName = map['lname'];
    this.imageUrl = map['imageUrl'];
  }

  toMap() {
    return {
      'city': this.city,
      'country': this.country,
      'fname': this.fName,
      'lname': this.lName,
      'imageUrl': this.imageUrl,
    };
  }
}
