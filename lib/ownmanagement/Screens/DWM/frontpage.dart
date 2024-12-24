import 'package:expenses/ownmanagement/Controller/frontpage_Controller.dart';
import 'package:expenses/ownmanagement/Screens/DRAWER/DrawersProfile.dart';
import 'package:expenses/ownmanagement/Screens/homepages/DialogBox.dart';
// import 'package:expenses/ownmanagement/Screens/DRAWER/DrawersProfile.dart';
// import 'package:expenses/ownmanagement/LOGINPAGES/Loginpage.dart';
import 'package:expenses/ownmanagement/Screens/homepages/mainstream.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class FrontPage extends StatelessWidget {
  FrontPage({super.key});

// ############################# Controller of Frontpage #####################
  final FrontPageController frontPageController = Get.put(FrontPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 234, 212, 181),
      // appBar: AppBar(
      //   automaticallyImplyLeading: true,
      //   iconTheme: IconThemeData(color: Colors.white),
      //   title: const Text(
      //     "Daily Bucket",
      //     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      //   ),
      //   backgroundColor: const Color.fromARGB(255, 203, 130, 11),
      // ),
      drawer: DrawerProfiles(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 218, 164, 18),

        onPressed: () {
          showDialog(context: context, builder: (context) => DialogBox());
        }, // to open dialog box
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Obx(() {
        // return streamreturn();
        if (frontPageController.expenses.isEmpty) {
          return streamreturn();
          // const Center(
          // child: Text('No Expenses Availabless'),
          // );
        } else {
          return streamreturn();
        }
      }),
    );
  }
}
