import 'package:expenses/ownmanagement/Controller/frontpage_Controller.dart';
import 'package:expenses/ownmanagement/LOGINPAGES/Loginpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});
  TextEditingController forgetpasssswordController = TextEditingController();
  final FrontPageController frontPageController = Get.put(FrontPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: Text(
          "Forget Password",
          style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              const SizedBox(height: 100),
              Container(
                alignment: Alignment.center,
                height: 250,
                child: Image.asset('assets/password.png'),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextFormField(
                  controller: forgetpasssswordController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.mail),
                    labelText: "E-Mail",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    )),
                    // suffixIcon: Icon(Icons.visibility_off_outlined)
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  var forgetEmail = forgetpasssswordController.text.trim();
                  frontPageController.forgetpass(forgetEmail);
                  Get.off(() => const LoginPage());
                },
                child: const Text("Forget Password"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
