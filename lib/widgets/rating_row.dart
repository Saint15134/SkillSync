import 'package:flutter/material.dart';

class RatingRow extends StatelessWidget {
  final int rating; // number of filled stars (0–5)
  final double size; // optional size of stars
  final Color color; // optional color for filled stars

  const RatingRow({
    super.key,
    required this.rating,
    this.size = 20,
    this.color = Colors.amber,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < rating) {
          return Icon(Icons.star, size: size, color: color);
        } else {
          return Icon(Icons.star, size: size, color: Colors.white24);
        }
      }),
    );
  }
}
