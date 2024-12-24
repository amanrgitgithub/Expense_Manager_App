import 'package:expenses/ownmanagement/Controller/frontpage_Controller.dart';
import 'package:expenses/ownmanagement/helper/date_time_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateDialogBox extends StatelessWidget {
  UpdateDialogBox({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final FrontPageController frontPageController = Get.find<FrontPageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Your Page Title'),
      // ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Color.fromARGB(255, 221, 147, 35),
          ),
          onPressed: () {
            // Call showDialog here
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return _buildAlertDialog(context);
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Tap to  Update\n Your Expenses',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }

  // Create a separate function that builds the AlertDialog
  Widget _buildAlertDialog(BuildContext context) {
    return Align(
      alignment: Alignment(0, -0.3), // Adjust the alignment to position dialog upwards
      child: AlertDialog(
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
              controller: _nameController,
              decoration: const InputDecoration(hintText: 'Enter Expense Name'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(hintText: 'Enter Expense Amount'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          // Save button
          TextButton(
            onPressed: () {
              if (_nameController.text.isEmpty || _amountController.text.isEmpty) {
                Get.snackbar('Error', 'Please Fill out all the fields');
                return;
              }
              DateTime now = DateTime.now();
              frontPageController.addExpense(
                _nameController.text,
                _amountController.text,
                DateTimeUtils().convertDateTimeToString(now),
              );
              _nameController.clear();
              _amountController.clear();
              Navigator.pop(context);
            },
            child: const Text(
              'Update',
              style: TextStyle(fontSize: 17),
            ),
          ),
          // Cancel button
          TextButton(
            onPressed: () {
              Navigator.pop(context);
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
