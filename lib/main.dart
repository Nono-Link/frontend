import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'common/nono_theme.dart';
import 'start/start_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ko'), Locale('ja')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ko'),
      child: const NonoLinkApp(),
    ),
  );
}

class NonoLinkApp extends StatelessWidget {
  const NonoLinkApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    key: ValueKey(context.locale),
    title: '노노링크',
    debugShowCheckedModeBanner: false,
    theme: NonoTheme.data(),
    localizationsDelegates: context.localizationDelegates,
    supportedLocales: context.supportedLocales,
    locale: context.locale,
    home: const StartPage(),
  );
}
