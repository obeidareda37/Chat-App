class RegisterRequest {
  String id;
  String fname;
  String lname;
  String password;
  String city;
  String country;
  String email;
  String imageUrl;

  RegisterRequest({
    this.id,
    this.fname,
    this.lname,
    this.password,
    this.city,
    this.country,
    this.email,
    this.imageUrl,
  });

  toMap() {
    return {
      'id': this.id,
      'fname': this.fname,
      'lname': this.lname,
      'city': this.city,
      'country': this.country,
      'email': this.email,
      'imageUrl': this.imageUrl,
    };
  }
}
