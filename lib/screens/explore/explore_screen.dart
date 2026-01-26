import 'package:flutter/material.dart';
import 'package:skillsync/widgets/bottom_nav.dart'; // make sure this exists

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900, // screen background

      body: Center(
        child: const Text(
          'Screen 11: Explore Screen',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      // ⬇️ Bottom navigation bar
      bottomNavigationBar: AppBottomNav(
        currentIndex: 2, // 0=Home, 1=Notifications, 2=Explore, 3=Chat, 4=Profile
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/notifications');
              break;
            case 2:
              // already on Explore, no action
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/community');
              break;
            case 4:
              Navigator.pushReplacementNamed(context, '/profile');
              break;
          }
        },
      ),
    );
  }
}
