import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses/ownmanagement/Controller/frontpage_Controller.dart';
import 'package:expenses/ownmanagement/Screens/DRAWER/Home_mover.dart';
import 'package:expenses/ownmanagement/LOGINPAGES/Loginpage.dart';
// import 'package:expenses/ownmanagement/Screens/frontpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    // print("Firebase Initialized");
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true, // Default settings, no need to specify host
    );
    await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
  } catch (e) {
    // ignore: avoid_print
    // print("Firebase initialization error: $e");
  }

  Get.put(FrontPageController(), permanent: true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FrontPageController frontPageController = Get.find<FrontPageController>();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Obx(() {
        return frontPageController.user.value != null ? ExpenseManagerHomePage() : const LoginPage();
        // return LoginPage();
      }),

      // home: LoginPage(),
    );
  }
}
