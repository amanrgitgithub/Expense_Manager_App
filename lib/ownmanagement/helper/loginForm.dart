import 'package:expenses/ownmanagement/Controller/frontpage_Controller.dart';
import 'package:expenses/ownmanagement/LOGINPAGES/SignUpPage.dart';
import 'package:expenses/ownmanagement/LOGINPAGES/forgetpassword.dart';
import 'package:expenses/ownmanagement/Screens/DWM/frontpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginForm extends StatelessWidget {
  LoginForm({super.key});
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();
  final FrontPageController frontPageController = Get.put(FrontPageController());

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Column(
          children: [
            //Email
            TextFormField(
              controller: loginEmailController,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: "E-Mail",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ))),
            ),
            const SizedBox(height: 16),
            // password
            Obx(
              () => TextFormField(
                controller: loginPasswordController,
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

            const SizedBox(height: 8),

            //remember me and forget password
            Padding(
              padding: const EdgeInsets.all(1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //remember me
                  Checkbox(value: true, onChanged: (value) {}),
                  const Text("Remember Me"),
                  const SizedBox(width: 20),

                  //forget password
                  TextButton(
                    onPressed: () {
                      Get.to(() => ForgetPassword());
                    },
                    child: const Text("Forget Password?"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // sign button
            SizedBox(
              height: 55,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final emailID = loginEmailController.text.trim();
                  final loginpass = loginPasswordController.text.trim();
                  frontPageController.enterDetailofUSer(emailID, loginpass);

                  // Get.to(() => FrontPage());
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
                child: const Text("Sign In"),
              ),
            ),
            const SizedBox(height: 16),

            // creae Account Button

            SizedBox(
              height: 55,
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(shadowColor: Colors.blue, side: BorderSide(color: Colors.blue), foregroundColor: Colors.black),
                onPressed: () {
                  Get.to(() => const SignUpPage());
                },
                child: const Text("Create Account"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
