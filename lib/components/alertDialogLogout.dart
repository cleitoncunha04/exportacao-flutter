import 'package:flutter/material.dart';

import '../pages/loginPage.dart';

class AlertDialogLogout extends StatelessWidget {
  const AlertDialogLogout({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text('Logout'),
      content: Text('Are you sure?'),
      actions: [
        Divider(
          thickness: 3,
          indent: 5,
          endIndent: 5,
          color: Theme.of(context).colorScheme.primary,
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {},
              child: Text('NO'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
              child: Text('YES'),
            ),
          ],
        ),
      ],
    );
  }
}
