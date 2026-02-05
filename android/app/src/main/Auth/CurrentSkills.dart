import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/skill.dart';

class CurrentSkillsScreen extends StatefulWidget {
  const CurrentSkillsScreen({super.key});

  @override
  State<CurrentSkillsScreen> createState() => _CurrentSkillsScreenState();
}

class _CurrentSkillsScreenState extends State<CurrentSkillsScreen> {
  List<Skill> _currentSkills = [];
  final List<Skill> _allSkills = [
    Skill(id: '1', name: 'Python', category: 'Programming'),
    Skill(id: '2', name: 'Java', category: 'Programming'),
    Skill(id: '3', name: 'JavaScript', category: 'Programming'),
    Skill(id: '4', name: 'Flutter', category: 'Mobile Dev'),
    Skill(id: '5', name: 'React', category: 'Web Dev'),
    Skill(id: '6', name: 'SQL', category: 'Database'),
    Skill(id: '7', name: 'Firebase', category: 'Backend'),
    Skill(id: '8', name: 'UI/UX Design', category: 'Design'),
    Skill(id: '9', name: 'Git', category: 'Tools'),
    Skill(id: '10', name: 'Docker', category: 'DevOps'),
  ];

  void _toggleSkill(Skill skill) {
    setState(() {
      final index = _currentSkills.indexWhere((s) => s.id == skill.id);
      if (index == -1) {
        _currentSkills.add(skill);
      } else {
        _currentSkills.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Current Skills',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 2.5,
              ),
              itemCount: _allSkills.length,
              itemBuilder: (context, index) {
                final skill = _allSkills[index];
                final isSelected = _currentSkills.any((s) => s.id == skill.id);

                return GestureDetector(
                  onTap: () => _toggleSkill(skill),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.blue.shade700
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? Colors.blue.shade900
                            : Colors.grey.shade300,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        skill.name,
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : Colors.grey.shade800,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: _currentSkills.isEmpty
                    ? null
                    : () => context.push('/new-skills'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                ),
                child: const Text(
                  'Next: Select Skills to Learn',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}