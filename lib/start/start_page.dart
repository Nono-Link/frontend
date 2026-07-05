import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../common/nono_theme.dart';
import '../common/widgets/nono_widgets.dart';
import '../login_expert/login_expert_page.dart';
import '../senior/senior_login_page.dart';
import '../scanner/scanner_login_page.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});
  @override
  Widget build(BuildContext context) => NonoPage(
    maxWidth: 640,
    children: [
      NonoHeader(
        title: 'start_app_title'.tr(),
        subtitle: 'start_app_subtitle'.tr(),
      ),
      const SizedBox(height: 22),
      NonoInfo(
        icon: '🩵',
        title: 'start_info_title'.tr(),
        body: 'start_info_body'.tr(),
        color: NonoTheme.coral,
      ),
      const SizedBox(height: 18),
      _RoleCard(
        emoji: '👵',
        title: 'start_role_senior_title'.tr(),
        desc: 'start_role_senior_desc'.tr(),
        chips: ['start_role_senior_chip_auth'.tr(), 'start_role_senior_chip_card'.tr(), 'start_role_senior_chip_chat'.tr()],
        page: const SeniorLoginPage(),
      ),
      const SizedBox(height: 14),
      _RoleCard(
        emoji: '📱',
        title: 'start_role_scanner_title'.tr(),
        desc: 'start_role_scanner_desc'.tr(),
        chips: ['start_role_scanner_chip_verify'.tr(), 'start_role_scanner_chip_qr'.tr(), 'start_role_scanner_chip_review'.tr()],
        page: const ScannerLoginPage(),
      ),
      const SizedBox(height: 14),
      _RoleCard(
        emoji: '🏛️',
        title: 'start_role_staff_title'.tr(),
        desc: 'start_role_staff_desc'.tr(),
        chips: ['start_role_staff_chip_login'.tr(), 'start_role_staff_chip_ocr'.tr(), 'start_role_staff_chip_issue'.tr()],
        page: const LoginExpertPage(),
      ),
    ],
  );
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.emoji,
    required this.title,
    required this.desc,
    required this.chips,
    required this.page,
  });
  final String emoji, title, desc;
  final List<String> chips;
  final Widget page;
  @override
  Widget build(BuildContext context) => NonoCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 34)),
            const SizedBox(width: 12),
            Expanded(child: Text(title, style: NonoTheme.h2)),
          ],
        ),
        const SizedBox(height: 8),
        Text(desc, style: NonoTheme.body),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: chips
              .map((e) => NonoChip(text: e, color: NonoTheme.navy))
              .toList(),
        ),
        const SizedBox(height: 16),
        NonoButton(
          text: 'start_role_start_button'.tr(namedArgs: {'title': title}),
          icon: Icons.arrow_forward,
          onTap: () =>
              Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
        ),
      ],
    ),
  );
}
