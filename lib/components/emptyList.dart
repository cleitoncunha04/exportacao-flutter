import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'The list is empty...',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.05,
        ),
        Image.asset(
          'lib/assets/images/empty.png',
          fit: BoxFit.fill,
          height: MediaQuery.sizeOf(context).height * 0.35,
        ),
      ],
    );
  }
}
