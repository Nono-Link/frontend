import 'package:flutter/material.dart';

class NonoTheme {
  static const cream = Color(0xFFFFF9F1);
  static const paper = Color(0xFFFFFDF9);
  static const charcoal = Color(0xFF1E293B);
  static const charcoalSoft = Color(0xFF475569);
  static const coral = Color(0xFFFF6B4A);
  static const green = Color(0xFF2F9E6E);
  static const red = Color(0xFFE63946);
  static const navy = Color(0xFF2A4365);
  static const line = Color(0xFFEADFCF);
  static const lineSoft = Color(0xFFF2E8D8);

  static ThemeData data() => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: cream,
    colorScheme: ColorScheme.fromSeed(seedColor: coral),
    fontFamily: 'Apple SD Gothic Neo',
  );

  static BoxShadow shadow = BoxShadow(
    color: Colors.brown.withOpacity(.12),
    blurRadius: 26,
    offset: const Offset(0, 12),
  );

  static const title = TextStyle(fontSize: 27, fontWeight: FontWeight.w900, color: charcoal, letterSpacing: -.6);
  static const h2 = TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: charcoal, letterSpacing: -.4);
  static const body = TextStyle(fontSize: 16, height: 1.5, color: charcoal, fontWeight: FontWeight.w700);
  static const muted = TextStyle(fontSize: 14, height: 1.45, color: charcoalSoft, fontWeight: FontWeight.w600);
}
