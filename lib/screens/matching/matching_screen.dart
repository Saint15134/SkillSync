import 'package:flutter/material.dart';
import 'package:skillsync/widgets/bottom_nav.dart';
import 'package:skillsync/widgets/app_appbar.dart';
import 'package:skillsync/widgets/primary_button.dart';
import 'package:skillsync/widgets/empty_state.dart';
import 'package:skillsync/widgets/rating_row.dart';
class MatchingScreen extends StatelessWidget {
  const MatchingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      // Reusable AppBar
      appBar: AppAppBar(title: 'Matching'),

      // Body scrollable and centered
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 🟦 MATCH CARD
                Container(
                  width: 320,
                  padding: const EdgeInsets.all(16),
                  color: Colors.grey.withOpacity(0.2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ⭐ Rating + ℹ️ Info
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const RatingRow(rating: 4),
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: const Icon(
                              Icons.info_outline,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/profile');
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // 👤 Username
                      const Center(
                        child: Text(
                          'Username',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // 📊 Skills exchange table header
                      Row(
                        children: const [
                          Expanded(
                            child: Text(
                              'Gives',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Receives',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Skill rows
                      const SkillRow(left: 'Skill 1', right: 'Skill A'),
                      const SkillRow(left: 'Skill 2', right: 'Skill B'),
                      const SkillRow(left: 'Skill 3', right: 'Skill C'),
                      const SkillRow(left: 'Skill 4', right: 'Skill D'),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // ✅ ACCEPT / ❌ DECLINE buttons
                PrimaryButton(
                  label: 'ACCEPT',
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/home',
                      (route) => false,
                    );
                  },
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  width: 180,
                ),

                const SizedBox(height: 12),

                PrimaryButton(
                  label: 'DECLINE',
                  onPressed: () {},
                  isDestructive: true,
                  width: 180,
                ),
              ],
            ),
          ),
        ),
      ),

      // ⬇️ Bottom navigation
      bottomNavigationBar: AppBottomNav(
        currentIndex: 2,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/notifications');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/explore');
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

// 📄 SkillRow widget
class SkillRow extends StatelessWidget {
  final String left;
  final String right;

  const SkillRow({super.key, required this.left, required this.right});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              left,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              right,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
