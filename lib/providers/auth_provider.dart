import 'dart:io';
import 'package:chat_app/auth/view/home_page.dart';
import 'package:chat_app/auth/view/login_page.dart';
import 'package:chat_app/auth/view/welcome_page.dart';
import 'package:chat_app/helpers/auth_helper.dart';
import 'package:chat_app/helpers/firestorage_helper.dart';
import 'package:chat_app/helpers/firestore_helper.dart';
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
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  List<UserModel> users = List<UserModel>();
  UserModel user;
  String myId;

  getUserFromFirestore() async {
    String userId = AuthHelper.authHelper.getUserId();
    user = await FirebaseHelpers.firebaseHelpers.getUserFromFirestore(userId);
    notifyListeners();
  }

  resetController() {
    emailController.clear();
    passwordController.clear();
    fNameController.clear();
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

  sendImageToChat([String message]) async{
    XFile file = await ImagePicker().pickImage(source: ImageSource.gallery);
    File file2=File(file.path);
    String imageUrl = await FirebaseStorageHelper.firebaseStorageHelper.uploadImage(file2,'chats');
    FirebaseHelpers.firebaseHelpers.addMessageToFirbaseFirestore({
      'userId':this.myId,
      'dateTime':DateTime.now(),
      'message':message??'',
      'imageUrl':imageUrl,
    });
  }
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
        city: selectedCity,
        country: selectedCountry.name,
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
    FirebaseHelpers.firebaseHelpers
        .getUserFromFirestore(userCredential.user.uid);
    this.myId = AuthHelper.authHelper.getUserId();
    getUserFromFirestore();
    RouteHelper.routeHelper.goToPageReplacement(HomePage.routeName);
    resetController();
  }

  checkLogin() {
    bool isLoggedIn = AuthHelper.authHelper.checkUserLoging();
    print(FirebaseAuth.instance.currentUser);
    if (isLoggedIn) {
      this.myId = AuthHelper.authHelper.getUserId();
      getUserFromFirestore();
      getAllUserFromFirestore();
      RouteHelper.routeHelper.goToPageReplacement(HomePage.routeName);
    } else {
      getUserFromFirestore();
      getAllUserFromFirestore();
      RouteHelper.routeHelper.goToPageReplacement(WelcomePage.routeName);
    }
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

   getAllUserFromFirestore() async {
    users = await FirebaseHelpers.firebaseHelpers.getAllUsersFromFirestore();
    users.removeWhere((element) => element.id==myId);
      notifyListeners();
  }

  // checkLogin() {
  //   bool isLoggedIn = AuthHelper.authHelper.checkUserLoging();
  //   print(FirebaseAuth.instance.currentUser);
  //   if (isLoggedIn) {
  //     RouteHelper.routeHelper.goToPageWithReplacement(HomePage.routeName);
  //   } else {
  //     RouteHelper.routeHelper.goToPageWithReplacement(AuthMainPage.routeName);
  //   }
  // }
  fillControllers() {
    fNameController.text = user.fname;
    countryController.text = user.country;
    cityController.text = user.city;
    emailController.text = user.email;
  }

  File updateFile;

  captureUpdateProfileImage() async {
    XFile file = await ImagePicker().pickImage(source: ImageSource.gallery);
    this.updateFile = File(file.path);
    notifyListeners();
  }

  updateProfile() async {
    String imageUrl;
    if (updateFile != null) {
      imageUrl = await FirebaseStorageHelper.firebaseStorageHelper
          .uploadImage(updateFile);
    }
    UserModel userModel = imageUrl == null
        ? UserModel(
            city: cityController.text,
            country: countryController.text,
            fname: fNameController.text,
            id: user.id,
          )
        : UserModel(
            city: cityController.text,
            country: countryController.text,
            fname: fNameController.text,
            id: user.id,
            imageUrl: imageUrl,
          );

    await FirebaseHelpers.firebaseHelpers.updateProfile(userModel);
    getUserFromFirestore();
    Navigator.of(RouteHelper.routeHelper.navKey.currentContext).pop();
  }
}
