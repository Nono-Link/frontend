import 'package:flutter/material.dart';
import 'common/nono_theme.dart';
import 'start/start_page.dart';

void main() => runApp(const NonoLinkApp());

class NonoLinkApp extends StatelessWidget {
  const NonoLinkApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: '노노링크',
    debugShowCheckedModeBanner: false,
    theme: NonoTheme.data(),
    home: const StartPage(),
  );
}
