import 'package:flutter/material.dart';

class CustomComment extends StatelessWidget {
  const CustomComment({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'User name',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text('Comment'),
          Text(
            'Replay',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text('Comment')
        ],
      ),
    );
  }
}
