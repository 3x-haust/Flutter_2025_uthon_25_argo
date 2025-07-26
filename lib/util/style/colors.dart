import 'package:flutter/material.dart';

class ThemeColors {
  final Color white;
  final Color gray01;
  final Color gray02;
  final Color gray03;
  final Color gray04;
  final Color gray05;
  final Color gray06;
  final Color gray07;
  final Color gray08;
  final Color gray09;
  final Color gray10;
  final Color gray11;
  final Color primaryPurple01;
  final Color primaryPurple02;


  ThemeColors({
    required this.white,
    required this.gray01,
    required this.gray02,
    required this.gray03,
    required this.gray04,
    required this.gray05,
    required this.gray06,
    required this.gray07,
    required this.gray08,
    required this.gray09,
    required this.gray10,
    required this.gray11,
    required this.primaryPurple01,
    required this.primaryPurple02,
  });

  static ThemeColors of(BuildContext context) {
    final isWhiteMode = Theme.of(context).brightness == Brightness.light;

    return ThemeColors(
      white: isWhiteMode ? const Color(0xffFFFFFF) : const Color(0xff000000),
      gray01: isWhiteMode ? const Color(0xffF2F2F8) : const Color(0xff1C1C1E),
      gray02: isWhiteMode ? const Color(0xffE4E5EA) : const Color(0xff2C2C2F),
      gray03: isWhiteMode ? const Color(0xffD1D1D7) : const Color(0xff3B393C), 
      gray04: isWhiteMode ? const Color(0xffC7C7CC) : const Color(0xff49484A),
      gray05: isWhiteMode ? const Color(0xffAEADB2) : const Color(0xff636366),
      gray06: isWhiteMode ? const Color(0xff8E8E93) : const Color(0xff8E8E93),
      gray07: isWhiteMode ? const Color(0xff636366) : const Color(0xffAEADB2),
      gray08: isWhiteMode ? const Color(0xff49484A) : const Color(0xffC7C7CC),
      gray09: isWhiteMode ? const Color(0xff3B393C) : const Color(0xffD1D1D7),
      gray10: isWhiteMode ? const Color(0xff2C2C2F) : const Color(0xffE4E5EA),
      gray11: isWhiteMode ? const Color(0xff1C1C1E) : const Color(0xffF2F2F8),
      primaryPurple01: isWhiteMode ? const Color(0xff652AC2) : const Color(0xff652AC2),
      primaryPurple02: isWhiteMode ? const Color(0xff090040) : const Color(0xff8882AE),
    );
  }
}