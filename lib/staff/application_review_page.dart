import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../common/nono_theme.dart';
import '../common/widgets/nono_widgets.dart';
import '../common/mock_backend_store.dart';
import 'card_preview_page.dart';

class ApplicationReviewPage extends StatefulWidget {
  const ApplicationReviewPage({super.key});
  @override
  State<ApplicationReviewPage> createState() => _ApplicationReviewPageState();
}

class _ApplicationReviewPageState extends State<ApplicationReviewPage> {
  final name = TextEditingController(text: 'staff_review_demo_name'.tr()),
      nickname = TextEditingController(text: 'staff_review_demo_nickname'.tr()),
      age = TextEditingController(text: 'staff_review_demo_age'.tr()),
      town = TextEditingController(text: 'staff_review_demo_town'.tr()),
      phone = TextEditingController(text: 'staff_review_phone_hint'.tr()),
      talent = TextEditingController(text: 'staff_review_demo_talent'.tr()),
      career = TextEditingController(text: 'staff_review_demo_career'.tr()),
      intro = TextEditingController(text: 'staff_review_demo_intro'.tr()),
      pref = TextEditingController(text: 'staff_review_demo_pref'.tr()),
      mood = TextEditingController(text: 'staff_review_demo_mood'.tr()),
      identCode = TextEditingController(text: '483920');
  @override
  Widget build(BuildContext context) => NonoPage(
    children: [
      NonoTop(title: 'staff_step_review_title'.tr(), subtitle: 'staff_review_subtitle'.tr()),
      const SizedBox(height: 16),
      NonoInfo(
        icon: '🔎',
        title: 'staff_review_info_title'.tr(),
        body: 'staff_review_info_body'.tr(),
        color: NonoTheme.coral,
      ),
      const SizedBox(height: 16),
      NonoCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('staff_review_basic_section_title'.tr(), style: NonoTheme.h2),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(child: NonoInput(label: 'staff_review_name_field_label'.tr(), controller: name, hint: 'staff_review_name_field_label'.tr())),
                const SizedBox(width: 12),
                Expanded(child: NonoInput(label: 'staff_review_nickname_label'.tr(), controller: nickname, hint: 'staff_review_demo_nickname'.tr())),
              ],
            ),
            NonoInput(label: 'staff_review_age_label'.tr(), controller: age, hint: 'staff_review_demo_age'.tr()),
            NonoInput(label: 'staff_review_town_label'.tr(), controller: town, hint: 'staff_review_demo_town'.tr()),
            NonoInput(label: 'staff_review_phone_label'.tr(), controller: phone, hint: 'staff_review_phone_hint'.tr()),
            NonoInput(label: 'staff_review_talent_label'.tr(), controller: talent, hint: 'staff_talent_hobby_label'.tr()),
            NonoInput(label: 'staff_review_career_label'.tr(), controller: career, hint: 'staff_review_demo_career'.tr()),
            NonoInput(
              label: 'staff_review_intro_label'.tr(),
              controller: intro,
              hint: 'staff_review_intro_hint'.tr(),
              maxLines: 3,
            ),
            NonoInput(
              label: 'staff_review_pref_label'.tr(),
              controller: pref,
              hint: 'staff_review_pref_hint'.tr(),
              maxLines: 2,
            ),
            NonoInput(label: 'staff_review_mood_label'.tr(), controller: mood, hint: 'staff_review_demo_mood'.tr()),
          ],
        ),
      ),
      const SizedBox(height: 16),
      NonoCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('staff_review_code_section_title'.tr(), style: NonoTheme.h2),
            const SizedBox(height: 4),
            Text('staff_review_code_section_desc'.tr(), style: NonoTheme.muted),
            const SizedBox(height: 14),
            NonoInput(label: 'staff_review_code_label'.tr(), controller: identCode, hint: '483920', keyboardType: TextInputType.number),
            const SizedBox(height: 8),
            NonoButton(
              text: 'staff_review_submit_button'.tr(),
              icon: Icons.badge,
              onTap: () {
                final code = identCode.text.trim();
                if (!MockBackendStore.instance.matchesPending(code)) {
                  nonoToast(context, 'staff_review_toast_code_mismatch'.tr());
                  return;
                }
                MockBackendStore.instance.issue(code, TalentCardData(
                  code: code,
                  name: name.text.trim(),
                  nickname: nickname.text.trim(),
                  intro: intro.text.trim(),
                  tags: [
                    talent.text.split(',').first.trim(),
                    ...pref.text.split('·').take(2).map((e) => e.trim()),
                  ],
                ));
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CardPreviewPage()),
                );
              },
            ),
          ],
        ),
      ),
    ],
  );
}
