import 'package:flutter/material.dart';

// Step 1: Screen class
class CommunityScreen extends StatelessWidget { // or StatefulWidget if it has changing data
  const CommunityScreen({super.key});

  // Step 2: Build method
  @override
  Widget build(BuildContext context) {
    // Step 3: Scaffold (screen skeleton)
    return Scaffold(
      backgroundColor: Colors.grey.shade900, // optional background color
      // Step 4: Body (main layout)
      body: Center(
        child: Text(
          'Screen 10: Community Screen',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
