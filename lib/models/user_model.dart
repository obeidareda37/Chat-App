import 'package:flutter/material.dart';

class UserModel {
  String id;
  String email;
  String city;
  String country;
  String fname;
  String imageUrl;

  UserModel({
    @required this.id,
    @required this.email,
    @required this.city,
    @required this.country,
    @required this.fname,
    @required this.imageUrl,
  });

  UserModel.fromMap(Map map) {
    this.id = map['id'];
    this.email = map['email'];
    this.city = map['city'];
    this.country = map['country'];
    this.fname = map['fname'];
    this.imageUrl = map['imageUrl'];
  }

  toMap() {
    return imageUrl == null
        ? {
            'fname': this.fname,
            'city': this.city,
            'country': this.country,
          }
        : {
            'fname': this.fname,
            'city': this.city,
            'country': this.country,
            'imageUrl': this.imageUrl,
          };
  }
}
