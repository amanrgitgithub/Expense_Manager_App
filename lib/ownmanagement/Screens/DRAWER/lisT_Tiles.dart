import 'package:flutter/material.dart';

class Listtiles extends StatelessWidget {
  final String name;
  final Icon icons;
  final VoidCallback onTap;
  Listtiles({
    required this.name,
    required this.icons,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(2),
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                  ),
                  Icon(Icons.arrow_forward_ios)
                ],
              ),
              leading: icons,
            ),
          ),
          const Divider(
            height: 4,
            // endIndent: 3,'
            thickness: 2,
            color: Colors.black12,
          ),
        ],
      ),
    );
  }
}
