// import 'package:flutter/material.dart';

// class DialogBox {
//   // Static method to show the dialog
//   static void showDialogBox(BuildContext context) {
//     final TextEditingController _nameController = TextEditingController();
//     final TextEditingController _amountController = TextEditingController();

//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Add New Expense'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: _nameController,
//               decoration: const InputDecoration(hintText: 'Enter Expense Name'),
//             ),
//             const SizedBox(height: 10),
//             TextField(
//               controller: _amountController,
//               decoration: const InputDecoration(hintText: 'Enter Expense Amount'),
//               keyboardType: TextInputType.number,
//             ),
//           ],
//         ),
//         actions: [
//           // Save button
//           TextButton(
//             onPressed: () {
//               final String name = _nameController.text;
//               final String amount = _amountController.text;

//               // Clear fields after use
//               _nameController.clear();
//               _amountController.clear();

//               // Close the dialog
//               Navigator.pop(context);
//             },
//             child: const Text('Save', style: TextStyle(fontSize: 17)),
//           ),
//           // Cancel button
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context); // Close the dialog
//             },
//             child: const Text('Cancel', style: TextStyle(fontSize: 17)),
//           ),
//         ],
//       ),
//     );
//   }
// }
