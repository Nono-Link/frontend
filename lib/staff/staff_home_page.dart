import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../common/nono_theme.dart';
import '../common/widgets/nono_widgets.dart';
import 'application_ocr_page.dart';
import 'application_review_page.dart';
import 'card_preview_page.dart';

class StaffHomePage extends StatelessWidget { const StaffHomePage({super.key});
  @override Widget build(BuildContext context) => NonoPage(children: [
    NonoTop(title: 'staff_home_title'.tr(), subtitle: 'staff_home_subtitle'.tr(), home: true),
    const SizedBox(height: 18),
    NonoInfo(icon: '✍️', title: 'staff_home_info_title'.tr(), body: 'staff_home_info_body'.tr(), color: NonoTheme.coral),
    const SizedBox(height: 16),
    _step(context, '1', 'staff_step_ocr_title'.tr(), 'staff_home_step1_desc'.tr(), Icons.document_scanner, const ApplicationOcrPage()),
    const SizedBox(height: 14),
    _step(context, '2', 'staff_step_review_title'.tr(), 'staff_home_step2_desc'.tr(), Icons.fact_check, const ApplicationReviewPage()),
    const SizedBox(height: 14),
    _step(context, '3', 'staff_home_step3_title'.tr(), 'staff_home_step3_desc'.tr(), Icons.badge, const CardPreviewPage()),
  ]);
  Widget _step(BuildContext context, String n, String title, String desc, IconData icon, Widget page) => NonoCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Row(children: [CircleAvatar(backgroundColor: NonoTheme.coral, child: Text(n, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900))), const SizedBox(width: 12), Icon(icon, color: NonoTheme.coral), const SizedBox(width: 8), Expanded(child: Text(title, style: NonoTheme.h2))]),
    const SizedBox(height: 10), Text(desc, style: NonoTheme.body), const SizedBox(height: 16),
    NonoButton(text: 'staff_home_step_button'.tr(namedArgs: {'title': title}), icon: Icons.arrow_forward, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => page))),
  ]));
}
