import 'package:flutter/material.dart';
import 'package:skillsync/widgets/rating_row.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 🔝 Banner + profile + back
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 180,
                    width: double.infinity,
                    color: Colors.white,
                  ),

                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(
                          0.35,
                        ), // subtle contrast
                        border: Border.all(
                          color: Colors.white54, // light outline
                          width: 1,
                        ),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: -40,
                    left: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: const Color.fromARGB(255, 47, 49, 53),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 50),

              // 👤 Username
              const Text(
                'Username',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 12),

              // 📝 Bio
              const Text('Bio', style: TextStyle(color: Colors.white70)),

              const SizedBox(height: 6),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  'This is a fake bio for now. Passionate learner, curious mind, and focused on meaningful collaboration.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),

              const SizedBox(height: 20),

              // ✅ Accept / ❌ Decline (rectangular)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _ActionButton(
                    label: 'ACCEPT',
                    color: Colors.green,
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/home',
                        (route) => false,
                      );
                    },
                  ),
                  const SizedBox(width: 12),
                  _ActionButton(
                    label: 'DECLINE',
                    color: Colors.red,
                    onPressed: () {},
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ⭐ Rating
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Rating', style: TextStyle(color: Colors.white)),
                  SizedBox(width: 8),
                  RatingRow(rating: 4),

                ],
              ),

              const SizedBox(height: 24),

              // 🛠 Skills
              const Text(
                'Skills',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 12),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 4.5, // 👈 makes them slim rectangles
                  children: const [
                    _SkillTile('Flutter'),
                    _SkillTile('Firebase'),
                    _SkillTile('UI/UX'),
                    _SkillTile('Python'),
                    _SkillTile('React'),
                    _SkillTile('Java'),
                  ],
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

// 🔘 Flat rectangular action button
class _ActionButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.label,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      height: 42,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          elevation: 0,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.clip,
          style: const TextStyle(fontWeight: FontWeight.w600, letterSpacing: 1),
        ),
      ),
    );
  }
}

// 🧩 Minimal skill rectangle
class _SkillTile extends StatelessWidget {
  final String label;
  const _SkillTile(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        border: Border.all(color: Colors.white24),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}
