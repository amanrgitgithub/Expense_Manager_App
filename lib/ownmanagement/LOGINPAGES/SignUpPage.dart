import 'package:expenses/ownmanagement/helper/divider.dart';
import 'package:expenses/ownmanagement/helper/signupFrom.dart';
import 'package:expenses/ownmanagement/helper/socialbutton.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Let's Create Your Account", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
              const SizedBox(height: 32),

              //form
              SinUpForm(),

              const SizedBox(height: 32),
//dividr
              const Dividers(),
              const SizedBox(height: 32),

//social buttopn
              const SocialButton(),
            ],
          ),
        ),
      ),
    );
  }
}
