import 'package:flutter/material.dart';

class CircleTag extends StatelessWidget {
  final double size;
  final String? text;
  final double? textSize;
  final Offset position;

  const CircleTag({
    super.key,
    required this.size,
    this.text,
    this.textSize,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF8C51E6),
              Color(0xFFD1AFFE),
            ],
          ),
          border: Border.fromBorderSide(
            BorderSide(
              color: Color(0xFF652AC2),
              width: 2,
            ),
          ),
        ),
        child: text != null
            ? Center(
                child: Text(
                  text!,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: textSize ?? 22,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            : null,
      ),
    );
  }
}
