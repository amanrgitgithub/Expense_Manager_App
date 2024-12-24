import 'package:expenses/ownmanagement/Controller/frontpage_Controller.dart';
import 'package:expenses/ownmanagement/helper/date_time_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogBox extends StatelessWidget {
  DialogBox({super.key});

  String? datetime;
  DateTime now = DateTime.now();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final FrontPageController frontPageController = Get.find<FrontPageController>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: Border.all(
        color: const Color.fromARGB(255, 181, 29, 9),
      ),
      title: const Text(
        'Add New Expense',
        style: TextStyle(fontSize: 25),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(hintText: 'Enter Expense Name'),
          ),

          //
          const SizedBox(height: 10),

          // expense amount field

          TextField(
            controller: _amountController,
            decoration: const InputDecoration(hintText: 'Enter Expense Amount'),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        //save button

        TextButton(
          onPressed: () {
            if (_nameController.text.isEmpty || _amountController.text.isEmpty) {
              Get.snackbar('Error', 'Please Fill out all the  fields');
              return;
            }
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
            'Save',
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
        )
      ],
    );
  }
}
