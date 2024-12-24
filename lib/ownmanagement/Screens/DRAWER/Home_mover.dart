import 'package:expenses/ownmanagement/Controller/frontpage_Controller.dart';
import 'package:expenses/ownmanagement/Screens/DRAWER/DrawersProfile.dart';
import 'package:expenses/ownmanagement/Screens/DWM/frontpage.dart';
import 'package:expenses/ownmanagement/Screens/DWM/monthly.dart';
import 'package:expenses/ownmanagement/Screens/DWM/weekely.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpenseManagerHomePage extends StatelessWidget {
  final FrontPageController frontPageController = Get.find<FrontPageController>();

  final List<Widget> pages = [
    FrontPage(),
    WeeklyExpensePage(),
    MonthlyExpensePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text(
          'Expense Manager',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 203, 130, 11),
        leading: Builder(
          builder: (context) {
            // Use Builder to create a context under the Scaffold
            return IconButton(
              icon: const Icon(
                Icons.menu,
                size: 33,
              ),
              onPressed: () {
                // Open the drawer using the context of the Builder
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: GestureDetector(
          onTap: () {
            print("Tapped on drawer");
          },
          child: DrawerProfiles()), // Observing the selectedIndex
      body: Obx(
        () => pages[frontPageController.selectedIndex.value],
      ),

      onDrawerChanged: (isOpen) {
        frontPageController.setDrawerState(isOpen); // Update state when drawer opens/closes
      },
      bottomNavigationBar: Obx(
        () => frontPageController.isDrawerOpen.value
            ? const SizedBox.shrink()
            : BottomNavigationBar(
                currentIndex: frontPageController.selectedIndex.value,
                onTap: (index) {
                  frontPageController.changeTabIndex(index);
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.today),
                    label: 'Daily',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_view_week),
                    label: 'Weekly',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_today),
                    label: 'Monthly',
                  ),
                ],
                selectedItemColor: Colors.white,
                unselectedItemColor: const Color.fromARGB(195, 230, 227, 227),
                backgroundColor: const Color.fromARGB(255, 217, 139, 4),
              ),
      ),
    );
  }
}
