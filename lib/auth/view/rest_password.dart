import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/widget/custom_button.dart';
import 'package:chat_app/widget/custom_text.dart';
import 'package:chat_app/widget/custom_text_field.dart';
import 'package:chat_app/widget/image_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetPassword extends StatelessWidget {
  static final routeName = 'reset';
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<AuthProvider>(
          builder: (context, provider, x) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    child: Center(
                      child: Column(
                        children: [
                          CustomText(
                            text: 'Forget Password',
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomText(
                            text:
                                'Enter the email address associated with this account',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ImageScreenWidget(
                            image: 'assets/images/security.jpg',
                            width: double.infinity,
                            height: 250,
                            marginTop: 20,
                            marginBottom: 10,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          CustomTextField(
                            hint: 'Email',
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: Colors.grey,
                            ),
                            controller: provider.emailController,
                          ),

                          SizedBox(height: 55,),

                          CustomButton(
                            function: (){
                              provider.resetPassword();
                            },
                            backgroundColor: Color(0xff1E58B6),
                            width: 220,
                            height: 50,
                            label: 'Reset Password',
                          ),
                        ],
                      ),
                    ),
                  ),
                  // // CustomTextField(
                  // //   controller: provider.emailController,
                  // //   label: 'Email',
                  // // ),
                  // MaterialButton(
                  //   onPressed: () {
                  //     provider.resetPassword();
                  //   },
                  //   child: Text(
                  //     'Reset Password',
                  //     style: TextStyle(color: Colors.white),
                  //   ),
                  //   color: Colors.blue,
                  // ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
