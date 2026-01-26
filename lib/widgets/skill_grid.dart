import 'package:flutter/material.dart';

class SkillGrid extends StatelessWidget {
  final List<String> skills;

  const SkillGrid({super.key, required this.skills});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 260,
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 3.5,
          ),
          itemCount: skills.length,
          itemBuilder: (context, index) {
            return Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
              ),
              child: Text(
                skills[index],
                style: const TextStyle(fontSize: 13),
              ),
            );
          },
        ),
      ),
    );
  }
}
