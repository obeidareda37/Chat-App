class RegisterRequest {
  String id;
  String fname;
  String password;
  String city;
  String country;
  String email;
  String imageUrl;

  RegisterRequest({
    this.id,
    this.fname,
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
      'city': this.city,
      'country': this.country,
      'email': this.email,
      'imageUrl': this.imageUrl,
    };
  }
}
