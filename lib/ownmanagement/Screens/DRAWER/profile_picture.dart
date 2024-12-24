import 'package:expenses/ownmanagement/Controller/drawerheadear_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final DrawerheadearControllers drawerheadearControllers = Get.put(DrawerheadearControllers());

    return Stack(
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
    );
  }
}
