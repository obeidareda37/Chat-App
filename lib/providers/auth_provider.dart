import 'dart:io';

import 'package:chat_app/auth/view/home_page.dart';
import 'package:chat_app/auth/view/login_page.dart';
import 'package:chat_app/auth/view/welcome_page.dart';
import 'package:chat_app/helpers/auth_helper.dart';
import 'package:chat_app/helpers/firestorage_helper.dart';
import 'package:chat_app/helpers/firestore_helper.dart';
import 'package:chat_app/helpers/shared_pref.dart';
import 'package:chat_app/models/country_model.dart';
import 'package:chat_app/models/register_request.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/service/routes_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    getCountriesFromFirestore();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  List<UserModel> users = List<UserModel>();

  UserModel user;

  getUserFromFirestore() async {
    String userId = AuthHelper.authHelper.getUserId();
    user = await FirebaseHelpers.firebaseHelpers.getUserFromFirestore(userId);
  }

  resetController() {
    emailController.clear();
    passwordController.clear();
    fNameController.clear();
    lNameController.clear();
    countryController.clear();
    cityController.clear();
  }

  List<CountryModel> countries;
  List<dynamic> cities = [];
  CountryModel selectedCountry;
  String selectedCity;

  selectCountry(CountryModel countryModel) {
    this.selectedCountry = countryModel;
    this.cities = countryModel.cities;
    selectCity(cities.first.toString());
    notifyListeners();
  }

  selectCity(dynamic city) {
    this.selectedCity = city;

    notifyListeners();
  }

  getCountriesFromFirestore() async {
    List<CountryModel> countries =
        await FirebaseHelpers.firebaseHelpers.getAllCountry();
    this.countries = countries;
    selectCountry(countries.first);
    notifyListeners();
  }

  ////////////////////////////////////////////////////////////////
  /// upload Image

  File file;

  selectFile() async {
    XFile imageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    this.file = File(imageFile.path);
    notifyListeners();
  }

  //////////////////////////////////////////////////////////////

  register() async {
    try {
      UserCredential userCredential = await AuthHelper.authHelper
          .signUp(emailController.text, passwordController.text);
      String imageUrl =
          await FirebaseStorageHelper.firebaseStorageHelper.uploadImage(file);
      RegisterRequest registerRequest = RegisterRequest(
        imageUrl: imageUrl,
        id: userCredential.user.uid,
        fname: fNameController.text,
        lname: lNameController.text,
        city: cityController.text,
        country: countryController.text,
        email: emailController.text,
        password: passwordController.text,
      );
      await FirebaseHelpers.firebaseHelpers.addUserToFirestore(registerRequest);
      await AuthHelper.authHelper.verifyEmail();
      await AuthHelper.authHelper.logOut();
      RouteHelper.routeHelper.goToPageReplacement(LoginPage.routeName);
    } on Exception catch (e) {
      // TODO
    }
    resetController();
  }

  logOut() async {
    await AuthHelper.authHelper.logOut();
    RouteHelper.routeHelper.goToPageReplacement(WelcomePage.routeName);
  }

  login() async {
    UserCredential userCredential = await AuthHelper.authHelper
        .signIn(emailController.text, passwordController.text);
    SpHelper.spHelper.saveUser(true);

    // bool isVerifiedEmail = AuthHelper.authHelper.checkEmailVerification();
    // if (isVerifiedEmail) {
    FirebaseHelpers.firebaseHelpers
        .getUserFromFirestore(userCredential.user.uid);
    RouteHelper.routeHelper.goToPageReplacement(HomePage.routeName);
    // } else {
    //   CustomDialog.customDialog.showCustomDialog(
    //     message:
    //         'you have to verify your email, press ok to send another email',
    //     function: sendVerification(),
    //   );
    // }
    resetController();
  }

  resetPassword() async {
    AuthHelper.authHelper.resetPassword(emailController.text);
    RouteHelper.routeHelper.goToPageReplacement(LoginPage.routeName);

    resetController();
  }

  sendVerification() async {
    AuthHelper.authHelper.verifyEmail();
    AuthHelper.authHelper.logOut();
  }

  Future<List<UserModel>> getAllUserFromFirestore() async {
    users = await FirebaseHelpers.firebaseHelpers.getAllUsersFromFirestore();
    return users;
    print(users.length);
  }
}
