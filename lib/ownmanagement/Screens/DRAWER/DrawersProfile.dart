import 'package:expenses/ownmanagement/Controller/frontpage_Controller.dart';
import 'package:expenses/ownmanagement/LOGINPAGES/Loginpage.dart';
import 'package:expenses/ownmanagement/Screens/DRAWER/User_Profile.dart';
import 'package:expenses/ownmanagement/Screens/DRAWER/drawerheaderphoto.dart';
import 'package:expenses/ownmanagement/Screens/DRAWER/lisT_Tiles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerProfiles extends StatelessWidget {
  DrawerProfiles({super.key});
  final FrontPageController frontPageController = Get.put(FrontPageController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawersHeaderswithPhoto(),
          Listtiles(
            name: "Profile",
            icons: Icon(Icons.person_2),
            onTap: () {
              Navigator.pop(context);
              frontPageController.setDrawerState(false);
              Get.to(() => UserProfile());
            },
          ),
          Listtiles(
            name: 'Expense Categories',
            icons: Icon(
              Icons.currency_rupee,
            ),
            onTap: () {
              Navigator.pop(context);
              frontPageController.setDrawerState(false);
              Get.to(() => UserProfile());
            },
          ),
          Listtiles(
            name: 'Settings',
            icons: Icon(Icons.settings),
            onTap: () {
              Navigator.pop(context);
              frontPageController.setDrawerState(false);
              Get.to(() => UserProfile());
            },
          ),
          const SizedBox(height: 390),
          ListTile(
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              Navigator.pop(context);
              frontPageController.setDrawerState(false);
              FirebaseAuth.instance.signOut();
              Get.offAll(() => const LoginPage());
            },
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
