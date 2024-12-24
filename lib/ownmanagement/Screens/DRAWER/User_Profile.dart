import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses/ownmanagement/Controller/drawerheadear_Controller.dart';
import 'package:expenses/ownmanagement/Controller/frontpage_Controller.dart';
import 'package:expenses/ownmanagement/Screens/DRAWER/profile_picture.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final FrontPageController frontPageController = Get.put(FrontPageController());
  final DrawerheadearControllers drawerheadearControllers = Get.put(DrawerheadearControllers());

  @override
  Widget build(BuildContext context) {
    // print("Fetching data for User ID: ${frontPageController.Userid.value}");

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        title: const Text(
          "Profile",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc(frontPageController.Userid.value).snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            if (snapshot.data!.exists) {
              Map<String, dynamic>? data = snapshot.data!.data() as Map<String, dynamic>?;
              if (data != null) {
                return Column(
                  children: [
                    const SizedBox(height: 50),
                    Obx(
                      () => CircleAvatar(
                        radius: 65,
                        backgroundImage: drawerheadearControllers.Image != null
                            ? FileImage(
                                drawerheadearControllers.Image!,
                              )
                            : null,
                        child: drawerheadearControllers.Image == null
                            ? const Icon(
                                Icons.person,
                                size: 70,
                                color: Colors.white,
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Reusable_For_Profile(
                      title: "Username",
                      value: data['username'],
                      iconData: Icons.person_outline,
                    ),
                    Reusable_For_Profile(
                      title: "E-mail",
                      value: data['EmailId'],
                      iconData: Icons.email_outlined,
                    ),
                    Reusable_For_Profile(
                      title: "Mobile.no",
                      value: data['Mobno'],
                      iconData: Icons.phone_outlined,
                    ),
                  ],
                );

                // ListTile(
                //   title: Text("Username: ${data['username'] ?? 'No username'}"),
                //   subtitle: Text("Email: ${data['EmailId'] ?? 'No email'}"),
                // );
              } else {
                return const Center(
                  child: Text("Data is null"),
                );
              }
            } else {
              return const Center(
                child: Text("No data found for this user."),
              );
            }
          } else {
            return const Center(
              child: Text("Something went wrong..."),
            );
          }
        },
      ),
    );
  }
}

class Reusable_For_Profile extends StatelessWidget {
  final String title, value;

  final IconData iconData;
  const Reusable_For_Profile({
    super.key,
    required this.title,
    required this.iconData,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ListTile(
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          leading: Icon(
            iconData,
            color: Colors.black,
          ),
          trailing: Text(
            value,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
        ),
        const Divider(color: Colors.black12, thickness: 2, height: 4),
        SizedBox(height: 20)
      ],
    );
  }
}
