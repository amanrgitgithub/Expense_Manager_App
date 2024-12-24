// ignore: file_names
// ignore_for_file: avoid_print
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses/ownmanagement/Screens/DRAWER/Home_mover.dart';
import 'package:expenses/ownmanagement/helper/date_time_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FrontPageController extends GetxController {
  // variables and functions

  var expenses = <ExpenseItem>[].obs;
  RxBool isObscure = true.obs;

  var user = Rxn<User>();
  Rxn<String> Userid = Rxn<String>(); // Store the UID reactively

  @override
  void onInit() {
    super.onInit();

    // FirebaseAuth.instance.setPersistence(Persistence.LOCAL);

    user.value = FirebaseAuth.instance.currentUser;
    print("Current User: ${user.value?.email}");

    // Listen to authentication changes
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      this.user.value = user;
      if (user != null) {
        print("User signed in: ${user.email}");
        fetchUserDetails(); // Ensure this is non-blocking
      } else {
        print("User signed out");
      }
    });
  }

// for password visibility and off
  void toggleVisibility() {
    isObscure.value = !isObscure.value;
  }

  // Listen to Firebase auth state changes
  void _listenToAuthChanges() {
    FirebaseAuth.instance.authStateChanges().listen((User? currentUser) {
      user.value = currentUser;
      if (currentUser != null) {
        Userid.value = currentUser.uid; // Update Userid with the current user's UID
        log('User logged in: ${Userid.value}');
      } else {
        Userid.value = null; // Clear Userid on logout
        log('User logged out');
      }
    });
  }

  // Fetch expenses from Firestore
  // void fetchExpenses() {
  //   FirebaseFirestore.instance.collection('newexpense').snapshots().listen((snapshot) {
  //     expenses.clear(); // Clear the existing list before adding new data
  //     for (var doc in snapshot.docs) {
  //       final expenseData = doc.data();
  //       print("Fetching expense: ${expenseData['name']}");
  //       expenses.add(ExpenseItem(
  //         name: expenseData['name'],
  //         amount: expenseData['amount'].toString(),
  //         dateTime: expenseData['dateTime'],
  //       ));
  //     }
  //     print("Total expenses fetched: ${expenses.length}");
  //   });
  // }

  // method to add new expense

  void addExpense(String name, String amount, String dateTime) async {
    double? parsedAmount = double.tryParse(amount);
    if (parsedAmount == null) {
      Get.snackbar('Error', 'Please Enter a valid number for the amount');
      return;
    }
    if (Userid.value == null) {
      Get.snackbar('Error', 'No user is logged in.');
      return;
    }

    try {
      log('Adding expense with UserID: ${Userid.value}'); // Log the User ID

      await FirebaseFirestore.instance
        ..collection('newexpense').doc().set({
          'name': name,
          'amount': parsedAmount,
          // 'dateTime': Timestamp.now(),
          'dateTime': DateTimeUtils().convertDateTimeToString(DateTime.now()),
          'userid': Userid.value,
        });

      // expenses.add(ExpenseItem(name: name, amount: amount, dateTime: dateTime));
      Get.snackbar('Success', 'Expense Added Successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to add expense: $e');
    }
  }

  /// Forget password controller
  void forgetpass(String forgetemail) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: forgetemail).then((value) => {
            print("Email Sent"),
          });
    } on FirebaseAuthException catch (e) {
      print("Error $e");
    }
  }

  // SIGNUP PAGE CONTROLLER

  void detailofuser(
    String fname,
    String lname,
    String uname,
    String email,
    String mobileno,
    String password,
  ) async {
    //validation
    if (fname.isEmpty || lname.isEmpty || uname.isEmpty || email.isEmpty || password.isEmpty || mobileno.isEmpty) {
      Get.snackbar('Error', 'All field are required');
      return;
    }

    if (password.length < 6) {
      Get.snackbar('Error', 'Password must be at least 6 Characters long');
      return;
    }
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) async {
        log("User Created");

        User? currentUser = FirebaseAuth.instance.currentUser;

        if (currentUser != null) {
          await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).set({
            'firstname': fname,
            'lastname': lname,
            'username': uname,
            'EmailId': email,
            'Mobno': mobileno,
            'createdat': DateTime.now(),
            'UserId': currentUser.uid,
          });
          log("Data Added");
        } else {
          log("Error: currentUser is null");
          Get.snackbar('Error', 'User creation failed. Please try again.');
        }
      });
    } on FirebaseAuthException catch (e) {
      print("Error $e");
    }
  }

  // LOGIN PAGE CONTROLLER

  void enterDetailofUSer(String mailid, String loginpassword) async {
    try {
      final User? firebaseUser = (await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: mailid,
        password: loginpassword,
      ))
          .user;
      if (firebaseUser != null) {
        print("User logged in: ${firebaseUser.email}");

        Userid.value = firebaseUser.uid; // Set Userid immediately upon login
        fetchUserDetails();
        // Adding a slight delay to ensure Firestore syncs
        // await Future.delayed(Duration(seconds: 1));

        Get.to(() => ExpenseManagerHomePage());
      } else {
        print("Check Email and Password");
      }
    } on FirebaseAuthException catch (e) {
      print("Error $e");
    }
  }

  //  Controller for the login and homescreen

  // HOME PAGE MOVER
  var selectedIndex = 0.obs;

  // Function to update index
  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }

// FETCH THE DETAIL OF USER FOR THE PROFILE SECTION
  RxString fname = ''.obs;
  RxString lname = ''.obs;

  void fetchUserDetails() {
    print("Inside fetchUserDetails()");
    if (Userid.value != null) {
      print("Attempting to fetch user details for UID: ${Userid.value}");
      FirebaseFirestore.instance.collection('users').doc(Userid.value).get().then((doc) {
        if (doc.exists) {
          fname.value = doc['firstname'] ?? '';
          lname.value = doc['lastname'] ?? '';
          print("Fetched fname: ${fname.value}, lname: ${lname.value}"); // Debugging log
          update();
        } else {
          print("No document found for UID: ${Userid.value}");
          Get.snackbar("Error", 'User Details not Found');
        }
      }).catchError((error) {
        print("Error fetching user details: $error");
        Get.snackbar('Error', 'Failed to Fetch user details: $error');
      });
    } else {
      print("Userid is null, cannot fetch details.");
    }
  }

  void listenToAuthChanges() {
    FirebaseAuth.instance.authStateChanges().listen((User? currentUser) {
      user.value = currentUser;
      if (currentUser != null) {
        Userid.value = currentUser.uid;
        print("User logged in: ${Userid.value}");
        fetchUserDetails(); // Fetch user details after login
      } else {
        Userid.value = null;
        print("User Loggged Out");
      }
    });
  }

  // TO CONTROL THE DRAWER

  // Observable variable to track the drawer's state
  var isDrawerOpen = false.obs;

  // Observable variable to track the selected tab index
  var selectedIndexs = 0.obs;

  // Method to change the selected tab index
  void changeTabIndexs(int index) {
    print('Tab index changed to: $index');
    selectedIndex.value = index;
  }

  // Method to update the drawer's state
  void setDrawerState(bool isOpen) {
    print('Drawer state changed to: $isOpen');

    isDrawerOpen.value = isOpen;
  }
}

// model class for an expense item
class ExpenseItem {
  final String name;
  final String amount;
  final String dateTime;

  ExpenseItem({
    required this.name,
    required this.amount,
    required this.dateTime,
  });
}
