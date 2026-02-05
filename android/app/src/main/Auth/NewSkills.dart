import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/skill.dart';

class NewSkillsScreen extends StatefulWidget {
  const NewSkillsScreen({super.key});

  @override
  State<NewSkillsScreen> createState() => _NewSkillsScreenState();
}

class _NewSkillsScreenState extends State<NewSkillsScreen> {
  List<Skill> _desiredSkills = [];
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
    Skill(id: '11', name: 'Machine Learning', category: 'AI'),
    Skill(id: '12', name: 'Blockchain', category: 'Emerging Tech'),
  ];

  void _toggleSkill(Skill skill) {
    setState(() {
      final index = _desiredSkills.indexWhere((s) => s.id == skill.id);
      if (index == -1) {
        _desiredSkills.add(skill);
      } else {
        _desiredSkills.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Skills to Learn',
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
                final isSelected = _desiredSkills.any((s) => s.id == skill.id);

                return GestureDetector(
                  onTap: () => _toggleSkill(skill),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: isSelected
                          ? LinearGradient(
                              colors: [
                                Colors.blue.shade300,
                                Colors.blue.shade600,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                          : LinearGradient(
                              colors: [
                                Colors.grey.shade100,
                                Colors.grey.shade200,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? Colors.blue.shade800
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
            child: Column(
              children: [
                if (_desiredSkills.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.green.shade300),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.green.shade700),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '${_desiredSkills.length} skill(s) selected',
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.green.shade800,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _desiredSkills.isEmpty
                        ? null
                        : () {
                            // Save to Firebase or show success
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Skills saved successfully!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                            Navigator.of(context).popUntil((route) => route.isFirst);
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade700,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                    ),
                    child: const Text(
                      'Save & Finish',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                  child: Text(
                    'Skip for now',
                    style: GoogleFonts.roboto(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}