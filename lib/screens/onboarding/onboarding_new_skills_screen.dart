import 'package:flutter/material.dart';

class OnboardingNewSkillsScreen extends StatelessWidget {
  const OnboardingNewSkillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Screen 4: Onboarding New Skills Screen',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/splash');
              },
              child: const Text('Confirm'),
            ),
          ],
        ),
      ),
    );
  }
}
