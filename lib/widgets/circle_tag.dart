import 'package:flutter/material.dart';

class CircleTag extends StatelessWidget {
  final String text;
  final Color color;
  final double? size;

  const CircleTag({
    super.key,
    required this.text,
    required this.color,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
