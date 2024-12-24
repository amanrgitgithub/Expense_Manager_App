import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses/ownmanagement/Controller/frontpage_Controller.dart';
import 'package:expenses/ownmanagement/Screens/CURD_OPERATION/edit_expense.dart';
import 'package:expenses/ownmanagement/Screens/homepages/update_expens.dart';
import 'package:expenses/ownmanagement/helper/date_time_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class streamreturn extends StatelessWidget {
  streamreturn({super.key});
  User? userId = FirebaseAuth.instance.currentUser;
  final FrontPageController frontPageController = Get.put(FrontPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('newexpense').where("userid", isEqualTo: userId?.uid).snapshots(),

        // stream: FirebaseFirestore.instance.collection('newexpense').where("userid", isEqualTo: userId?.uid).orderBy('dateTime', descending: true).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            log('Stream error: ${snapshot.error}');
            return const Text("Something went wrong");
          }
          // Show loading spinner while waiting for data
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No Data Found"));
          }
          if (snapshot != null && snapshot.data != null) {
            log('Snapshot data: ${snapshot.data!.docs}');
          }
          if (snapshot != null && snapshot.data != null) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var kharcha = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                var docId = snapshot.data!.docs[index].id;
                var expensename = kharcha['name'];
                var amounts = kharcha['amount'];

                return Padding(
                  padding: const EdgeInsets.all(8.0),

                  ///#########DISMISSIBLE#################################
                  child: Dismissible(
                    key: Key(kharcha['name']),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: const Color.fromARGB(255, 244, 54, 54),
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    onDismissed: (direction) async {
                      FirebaseFirestore.instance.collection("newexpense").doc(docId).delete();
                      // frontPageController.expenses.removeAt(index);
                      Get.snackbar("Deleted", ' ${kharcha['name']} removed');
                    },
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Color.fromARGB(255, 243, 168, 93)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      title: Text(
                        kharcha['name'],
                        style: const TextStyle(fontSize: 18),
                      ),
                      subtitle: Text(
                        kharcha['dateTime'],
                        style: const TextStyle(fontSize: 14),
                      ),
                      trailing: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              ' ₹${kharcha['amount']}/-',
                              style: const TextStyle(fontSize: 16),
                            ),
                            SizedBox(width: 10),
                            IconButton(
                              onPressed: () {
                                // print("Your Expense is : -  $expensename");
                                // print("Your Expense is : -  ${kharcha['name']}");
                                Get.to(
                                  () => EditExpense(),
                                  arguments: {
                                    'expense_name': expensename,
                                    'amount_update': amounts,
                                    'docIDs': docId
                                  },
                                );
                              },
                              icon: const Icon(Icons.edit),
                            ),
                            // IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return Center(child: Text("No Data Available"));
        },
      ),
    );
  }
}
