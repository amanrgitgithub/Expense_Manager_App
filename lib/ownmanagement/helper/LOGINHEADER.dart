import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // logo //titile//subtitle
          Image(
            height: 150,
            image: AssetImage("assets/dark.png"),
          ),
          Text(
            "Welcome back,",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            "Track your Daily Expenses and Minimize your Daily Expenses",
            style: TextStyle(fontSize: 14),
          ),
        ]);
  }
}
