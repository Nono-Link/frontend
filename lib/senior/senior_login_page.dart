import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../common/nono_theme.dart';
import '../common/widgets/nono_widgets.dart';
import 'my_talent_card_page.dart';

class SeniorLoginPage extends StatefulWidget {
  const SeniorLoginPage({super.key});
  @override
  State<SeniorLoginPage> createState() => _SeniorLoginPageState();
}

class _SeniorLoginPageState extends State<SeniorLoginPage> {
  final name = TextEditingController(),
      nickname = TextEditingController(),
      phone = TextEditingController(),
      code = TextEditingController();
  bool sent = false;
  @override
  Widget build(BuildContext context) => NonoPage(
    children: [
      NonoTop(title: 'senior_login_title'.tr(), subtitle: 'senior_login_subtitle'.tr()),
      const SizedBox(height: 20),
      NonoCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '👵',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 58),
            ),
            const SizedBox(height: 8),
            Text(
              'senior_login_heading'.tr(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.w900,
                color: NonoTheme.charcoal,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'senior_login_description'.tr(),
              textAlign: TextAlign.center,
              style: NonoTheme.body.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: NonoInput(label: 'senior_login_name_label'.tr(), controller: name, hint: 'senior_login_name_hint'.tr()),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: NonoInput(
                    label: 'senior_login_nickname_label'.tr(),
                    controller: nickname,
                    hint: 'senior_login_nickname_hint'.tr(),
                  ),
                ),
              ],
            ),
            NonoInput(
              label: 'senior_login_phone_label'.tr(),
              controller: phone,
              hint: '010-1234-5678',
              keyboardType: TextInputType.phone,
            ),
            if (sent)
              NonoInput(
                label: 'senior_login_code_label'.tr(),
                controller: code,
                hint: '123456',
                keyboardType: TextInputType.number,
              ),
            NonoButton(
              text: sent ? 'senior_view_card_button'.tr() : 'senior_login_request_code_button'.tr(),
              icon: sent ? Icons.badge : Icons.sms,
              onTap: () {
                if (!sent) {
                  setState(() => sent = true);
                  nonoToast(context, 'senior_login_toast_code_sent'.tr());
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const MyTalentCardScreen(code: '483920')),
                  );
                }
              },
            ),
            const SizedBox(height: 16),
            NonoInfo(
              icon: '✍️',
              title: 'senior_login_info_title'.tr(),
              body: 'senior_login_info_body'.tr(),
              color: NonoTheme.coral,
            ),
          ],
        ),
      ),
    ],
  );
}
