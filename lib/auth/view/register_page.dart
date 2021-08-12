import 'package:chat_app/auth/providers/auth_provider.dart';
import 'package:chat_app/auth/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Consumer<AuthProvider>(
        builder: (context, provider, x) {
          return Column(
            children: [
              CustomTextField(
                label: 'Email',
                controller: provider.emailController,
              ),
              CustomTextField(
                label: 'Password',
                controller: provider.passwordController,
              ),
              MaterialButton(
                onPressed: () {
                  provider.register();
                },
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
              ),
            ],
          );
        },
      ),
    );
  }
}
