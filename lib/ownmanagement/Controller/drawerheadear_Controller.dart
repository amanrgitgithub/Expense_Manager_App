import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerheadearControllers extends GetxController {
  Rxn<File?> _image = Rxn<File?>();

  final picker = ImagePicker();
  File? get Image => _image.value;

  Future getGalleryImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      _image.value = File(pickedFile.path);
      await saveImageLocally(_image.value!);

      // await uploadImageToFirebase();
    } else {
      // ignore: avoid_print
      print("No image Picked");
    }
  }
//// TO STORE FILE OR IMAGE IN FIREBASE STROE AND RETRIVE OR FETCH DURING THE LOGIN OF PSRTICULSR USER
  // Future uploadImageToFirebase() async {
  //   if (_image.value != null) {
  //     try {
  //       //  Get the currently ligged in User

  //       User? user = FirebaseAuth.instance.currentUser;
  //       if (user != null) {
  //         // define the file path in firebase storage
  //         String filePath = 'profile_pictures/${user.uid}.jpg';

  //         // upload the file to firebase storage
  //         final storageRef = FirebaseStorage.instance.ref().child(filePath);
  //         await storageRef.putFile(_image.value!);

  //         // Get the download URL and store it in Firestore or another database
  //         String downloadURL = await storageRef.getDownloadURL();

  //         // Save the download URL to Firestore
  //         await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
  //           'profilePicture': downloadURL,
  //         });
  //       }
  //     } catch (e) {
  //       print("Error Uploading image: $e ");
  //     }
  //   }
  // }

  // Save image to local storage and save the path in SharedPreferences
  Future<void> saveImageLocally(File imageFile) async {
    try {
      Directory appDir = await getApplicationDocumentsDirectory();
      String filePath = '${appDir.path}/profile_picture.jpg';

      // Copy the image file to the app's local directory
      await imageFile.copy(filePath);

      // Save the file path to SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_picture_path', filePath);
      print("Image saved locally at: $filePath");
    } catch (e) {
      print("Error saving image locallyy: $e");
    }
  }

  // Load image from local storage
  Future<void> loadProfilePicture() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? filePath = prefs.getString('profile_picture_path');

    if (filePath != null) {
      _image.value = File(filePath); // Load the file into the image variable
      print("Image loaded from: $filePath");
    } else {
      print("No profile picture found in local storage");
    }
  }
}
