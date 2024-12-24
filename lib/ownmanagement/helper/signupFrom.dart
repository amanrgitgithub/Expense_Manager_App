import 'package:expenses/ownmanagement/Controller/frontpage_Controller.dart';
import 'package:expenses/ownmanagement/LOGINPAGES/Loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SinUpForm extends StatelessWidget {
  SinUpForm({super.key});
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController useremailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FrontPageController frontPageController = Get.put(FrontPageController());

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: firstnameController,
                expands: false,
                decoration: const InputDecoration(
                    labelText: "First Name",
                    prefixIcon: Icon(Icons.person_2_outlined),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(18),
                    ))),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: lastnameController,
                expands: false,
                decoration: const InputDecoration(
                    labelText: "Last Name",
                    prefixIcon: Icon(Icons.person_2_outlined),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(18),
                    ))),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // user Name
        TextFormField(
          controller: usernameController,
          expands: false,
          decoration: const InputDecoration(
              labelText: 'UserName',
              prefixIcon: Icon(Icons.person_2),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                Radius.circular(18),
              ))),
        ),
        const SizedBox(
          height: 16,
        ),

        // email
        TextFormField(
          controller: useremailController,
          decoration: const InputDecoration(
              labelText: 'E-Mail',
              prefixIcon: Icon(Icons.email_outlined),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                Radius.circular(18),
              ))),
        ),
        const SizedBox(
          height: 16,
        ),
        // phone number

        TextFormField(
          controller: mobileController,
          expands: false,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
              labelText: 'Mobile',
              prefixIcon: Icon(Icons.phone_android),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                Radius.circular(18),
              ))),
        ),
        const SizedBox(
          height: 16,
        ),
///////////////////////////////////////
        // password
        Obx(
          () => TextFormField(
            controller: passwordController,
            obscureText: frontPageController.isObscure.value, // React to Change
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(frontPageController.isObscure.value ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  frontPageController.toggleVisibility();
                },
              ),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                Radius.circular(18),
              )),
            ),
          ),
        ),

        //////////////
        const SizedBox(
          height: 32,
        ),

        ///Sign up Button
        SizedBox(
          height: 50,
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
            onPressed: () {
              final firstName = firstnameController.text.trim();
              final lastName = lastnameController.text.trim();
              final userName = usernameController.text.trim();
              final useremail = useremailController.text.trim();
              final mobile = mobileController.text.trim();
              final password = passwordController.text.trim();

              frontPageController.detailofuser(
                firstName,
                lastName,
                userName,
                useremail,
                mobile,
                password,
              );
              Get.to(() => const LoginPage());
              FirebaseAuth.instance.signOut();
            },
            child: const Text(
              "Create Account",
              style: TextStyle(fontSize: 18),
            ),
          ),
        )
      ],
    ));
  }
}
