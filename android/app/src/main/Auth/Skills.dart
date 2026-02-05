class Skill {
  final String id;
  final String name;
  final String category;
  bool isSelected;

  Skill({
    required this.id,
    required this.name,
    required this.category,
    this.isSelected = false,
  });

  Skill toggle() => Skill(
        id: id,
        name: name,
        category: category,
        isSelected: !isSelected,
      );
}