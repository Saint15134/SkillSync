import 'package:flutter/material.dart';

class OnboardingCurrentSkillsScreen extends StatelessWidget {
  const OnboardingCurrentSkillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, // keeps content centered nicely
          children: [
            const Text(
              'Screen 3: Onboarding Current Skills Screen',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/onboarding_new');
              },
              child: const Text('Confirm'),
            ),
          ],
        ),
      ),
    );
  }
}
