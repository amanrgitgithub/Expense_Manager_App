import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses/ownmanagement/Controller/frontpage_Controller.dart';
import 'package:expenses/ownmanagement/Screens/DRAWER/Home_mover.dart';
import 'package:expenses/ownmanagement/helper/date_time_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditExpense extends StatelessWidget {
  EditExpense({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final FrontPageController frontPageController = Get.find<FrontPageController>();

  @override
  Widget build(BuildContext context) {
    // Use GetX to show the dialog when this widget is loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showDialog(context);
    });

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 203, 130, 11),
        foregroundColor: Colors.white,
        title: Text(
          "Update Expenses",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      // Keeping the body empty since the dialog is shown directly
      body: Container(),
    );
  }

  // Method to show the dialog using GetX
//   void _showDialog(BuildContext context) {
//     Get.dialog(
//       AlertDialog(
//         shape: Border.all(
//           color: const Color.fromARGB(255, 181, 29, 9),
//         ),
//         title: const Text(
//           'Update Expenses',
//           style: TextStyle(fontSize: 25),
//         ),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: _nameController..text = "${Get.arguments['expense_name'].toString()}",
//               decoration: const InputDecoration(hintText: 'Enter Expense Name'),
//             ),
//             const SizedBox(height: 10),
//             TextField(
//               controller: _amountController..text = "${Get.arguments['amount_update'].toInt()}",
//               decoration: const InputDecoration(hintText: 'Enter Expense Amount'),
//               keyboardType: TextInputType.number,
//             ),
//           ],
//         ),
//         actions: [
//           // Save button
//           TextButton(
//             onPressed: () async {
//               if (_nameController.text.isEmpty || _amountController.text.isEmpty) {
//                 Get.snackbar('Error', 'Please Fill out all the fields');
//                 return;
//               }
//               // DateTime now = DateTime.now();
//               // frontPageController.addExpense(
//               //   _nameController.text,
//               //   _amountController.text,
//               //   DateTimeUtils().convertDateTimeToString(now),
//               // );
//               // final docId = arguments['docIDs']?.toString();
//               await FirebaseFirestore.instance.collection("newexpense").doc(Get.arguments['docIDs'].toString()).update({
//                 'name': _nameController.text.trim(),
//                 'amount': _amountController.text.trim(),
//               });

//               _nameController.clear();
//               _amountController.clear();
//               Get.back(); // Close the dialog
//               Navigator.pop(context);
//             },
//             child: const Text(
//               'Update',
//               style: TextStyle(fontSize: 17),
//             ),
//           ),
//           // Cancel button
//           TextButton(
//             onPressed: () {
//               Get.back(); // Close the dialog
//               Navigator.pop(context);
//             },
//             child: const Text(
//               'Cancel',
//               style: TextStyle(fontSize: 17),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

  void _showDialog(BuildContext context) {
    final arguments = Get.arguments ?? {}; // Provide an empty map as a fallback

    Get.dialog(
      AlertDialog(
        shape: Border.all(
          color: const Color.fromARGB(255, 181, 29, 9),
        ),
        title: const Text(
          'Update Expenses',
          style: TextStyle(fontSize: 25),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController..text = Get.arguments != null && Get.arguments['expense_name'] != null ? Get.arguments['expense_name'].toString() : '',

              // controller: _nameController..text = "${Get.arguments['expense_name'].toString()}",
              decoration: const InputDecoration(hintText: 'Enter Expense Name'),
            ),
            const SizedBox(height: 10),
            TextField(
              // controller: _amountController..text = "${Get.arguments['amount_update'].toString()}",
              controller: _amountController..text = (Get.arguments != null && Get.arguments['amount_update'] != null) ? Get.arguments['amount_update'].toString() : '', // Default to empty string if null

              decoration: const InputDecoration(hintText: 'Enter Expense Amount'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (_nameController.text.isEmpty || _amountController.text.isEmpty) {
                Get.snackbar('Error', 'Please Fill out all the fields');
                return;
              }
              final docId = arguments['docIDs']?.toString();
              if (docId != null) {
                await FirebaseFirestore.instance.collection("newexpense").doc(docId).update({
                  'name': _nameController.text.trim(),
                  'amount': _amountController.text.trim(),
                });
              }
              Get.snackbar('Success', 'Expense Updated Successfully');

              _nameController.clear();
              _amountController.clear();
              Get.to(() => ExpenseManagerHomePage());
              // Get.back(); // Close the dialog
            },
            child: const Text(
              'Update',
              style: TextStyle(fontSize: 17),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back(); // Close the dialog
              Get.back(); // Close the dialog
            },
            child: const Text(
              'Cancel',
              style: TextStyle(fontSize: 17),
            ),
          ),
        ],
      ),
    );
  }
}
