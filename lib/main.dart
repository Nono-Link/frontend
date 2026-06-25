import 'package:flutter/material.dart';
import 'login_expert/login_expert_page.dart';

void main() {
  runApp(const NonolinkApp());
}

class NonolinkApp extends StatelessWidget {
  const NonolinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '노노링크',
      debugShowCheckedModeBanner: false,
      home: const LoginExpertPage(),
    );
  }
}