import 'package:flutter/material.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      // Outer decoration for the shadow and dynamic surface background
      decoration: BoxDecoration(
        // 🟢 Uses surface (White in Light, Deep Charcoal in Dark)
        color: colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
        boxShadow: [
          BoxShadow(
            // 🟢 Subtler shadow for dark mode to prevent "muddy" edges
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          type: BottomNavigationBarType.fixed,
          // 🟢 Link background to surface
          backgroundColor: colorScheme.surface,
          elevation: 0, 
          
          // 🟢 Link active/inactive states to theme primary and secondary
          selectedItemColor: colorScheme.primary,   
          unselectedItemColor: colorScheme.secondary, 
          
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w600, 
            fontSize: 12,
            letterSpacing: -0.2,
            color: colorScheme.primary,
          ),
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w500, 
            fontSize: 12,
            color: colorScheme.secondary,
          ),
          
          items: const [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.home_rounded),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.notifications_rounded),
              ),
              label: 'Alerts',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.swipe_rounded), 
              ),
              label: 'Match',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.groups_rounded),
              ),
              label: 'Social',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.person_rounded),
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}