import 'dart:io';

import 'package:expenses/ownmanagement/Controller/drawerheadear_Controller.dart';
import 'package:expenses/ownmanagement/Controller/frontpage_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class DrawersHeaderswithPhoto extends StatelessWidget {
  // #######################################################

  final DrawerheadearControllers drawerheadearControllers = Get.put(DrawerheadearControllers());
  final FrontPageController frontPageController = Get.put(FrontPageController());

  // #####################################################
  DrawersHeaderswithPhoto({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    drawerheadearControllers.loadProfilePicture();
    return DrawerHeader(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 203, 130, 11),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Obx(
                () => CircleAvatar(
                  radius: 44,
                  backgroundImage: drawerheadearControllers.Image != null
                      ? FileImage(
                          drawerheadearControllers.Image!,
                        )
                      : null,
                  child: drawerheadearControllers.Image == null
                      ? const Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.white,
                        )
                      : null,
                ),
              ),
              Positioned(
                child: IconButton(
                  onPressed: drawerheadearControllers.getGalleryImage,
                  icon: Icon(
                    Icons.add_a_photo,
                    color: Colors.white,
                  ),
                ),
                bottom: -15,
                left: 52,
              ),
            ],
          ),
          Obx(() {
            if (frontPageController.fname.value.isEmpty || frontPageController.lname.value.isEmpty) {
              return const Text(
                "\n Loading...",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                overflow: TextOverflow.ellipsis,
              );
            } else {
              return Text(
                "\n ${frontPageController.fname.value} ${frontPageController.lname.value}",
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                // overflow: TextOverflow.ellipsis,
              );
            }
          }),
        ],
      ),
    );
  }
}
