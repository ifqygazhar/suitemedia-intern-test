import 'package:flutter/material.dart';

class NoMoreUserWidget extends StatelessWidget {
  const NoMoreUserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(height: 16),
          Icon(Icons.people_outline, size: 32, color: Colors.grey),
          SizedBox(height: 8),
          Text(
            'No more users to load',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            'You have reached the end of the list',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
