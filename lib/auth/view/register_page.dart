import 'package:chat_app/models/country_model.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/service/routes_helpers.dart';
import 'package:chat_app/widget/custom_button.dart';
import 'package:chat_app/widget/custom_text.dart';
import 'package:chat_app/widget/custom_text_field.dart';
import 'package:chat_app/widget/custom_text_password_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  static final routeName = 'register';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<AuthProvider>(
          builder: (context, provider, x) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Center(
                      child: Column(
                        children: [
                          CustomText(
                            text: 'Sign Up',
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomText(
                            text: 'Fill the details & create your account',
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Stack(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 80.0,
                          backgroundImage: provider.file == null
                              ? AssetImage("assets/images/profile.jpeg")
                              : FileImage(provider.file),
                        ),
                        Positioned(
                          bottom: 20.0,
                          right: 20.0,
                          child: InkWell(
                            onTap: () {
                              provider.selectFile();
                            },
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.teal,
                              size: 28.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     provider.selectFile();
                    //   },
                    //   child: CircleAvatar(
                    //     backgroundImage: Image.network(),
                    //     radius: 80,
                    //     child: provider.file == null
                    //         ? Container()
                    //         : Image.file(
                    //             provider.file,
                    //             fit: BoxFit.cover,
                    //           ),
                    //   ),
                    // child: Container(
                    //   height: 200,
                    //   width: 200,
                    //   color: Colors.grey,
                    //   child: provider.file == null
                    //       ? Container()
                    //       : Image.file(
                    //           provider.file,
                    //           fit: BoxFit.cover,
                    //         ),
                    // ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    hint: 'first Name',
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Colors.grey,
                    ),
                    controller: provider.fNameController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    hint: 'last Name',
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Colors.grey,
                    ),
                    controller: provider.lNameController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    hint: 'Email',
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Colors.grey,
                    ),
                    controller: provider.emailController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextPasswordField(
                    textInputType: TextInputType.visiblePassword,
                    controller: provider.passwordController,
                    hint: 'password',
                    prefixIcon: Icon(
                      Icons.lock_open_outlined,
                      color: Colors.grey,
                    ),
                    obscureText: obscureText,
                    onTap: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  provider.countries == null
                      ? Container()
                      : Container(
                          padding: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey),
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: DropdownButton<CountryModel>(
                            isExpanded: true,
                            underline: Container(),
                            onChanged: (x) {
                              provider.selectCountry(x);
                            },
                            value: provider.selectedCountry,
                            items: provider.countries.map((e) {
                              return DropdownMenuItem<CountryModel>(
                                child: Text(e.name),
                                value: e,
                              );
                            }).toList(),
                          ),
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  provider.cities == null
                      ? Container()
                      : Container(
                          padding: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey),
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: DropdownButton<dynamic>(
                            isExpanded: true,
                            underline: Container(),
                            onChanged: (x) {
                              provider.selectCity(x);
                            },
                            value: provider.selectedCity,
                            items: provider.cities.map((e) {
                              return DropdownMenuItem<dynamic>(
                                child: Text(e),
                                value: e,
                              );
                            }).toList(),
                          ),
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    function: () {
                      provider.register();
                    },
                    backgroundColor: Color(0xff1E58B6),
                    width: 220,
                    height: 50,
                    label: 'Sign Up',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: 'Do you have an account?',
                        colorText: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      GestureDetector(
                        onTap: () {
                          RouteHelper.routeHelper.goToPage(LoginPage.routeName);
                        },
                        child: CustomText(
                          text: 'Login',
                          colorText: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
