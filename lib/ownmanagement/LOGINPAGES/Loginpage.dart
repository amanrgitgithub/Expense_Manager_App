import 'package:expenses/ownmanagement/helper/LOGINHEADER.dart';
import 'package:expenses/ownmanagement/helper/divider.dart';
import 'package:expenses/ownmanagement/helper/loginForm.dart';
import 'package:expenses/ownmanagement/helper/socialbutton.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 56, left: 24, right: 24, bottom: 24),
          child: Column(
            children: [
              // logo // headr//subtitle
              LoginHeader(),

              // form
              LoginForm(),

              //divider
              Dividers(),

              SizedBox(height: 32),

              // Footer
              SocialButton(),
            ],
          ),
        ),
      ),
    );
  }
}
