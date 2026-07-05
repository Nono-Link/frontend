import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../common/nono_theme.dart';
import '../common/widgets/nono_widgets.dart';
import 'qr_scan_page.dart';

class ScannerLoginPage extends StatefulWidget {
  const ScannerLoginPage({super.key});
  @override
  State<ScannerLoginPage> createState() => _ScannerLoginPageState();
}

class _ScannerLoginPageState extends State<ScannerLoginPage> {
  final name = TextEditingController(text: 'scanner_login_name_hint'.tr()),
      nickname = TextEditingController(),
      phone = TextEditingController(text: '010-9999-0000');
  bool verified = false;
  @override
  Widget build(BuildContext context) => NonoPage(
    children: [
      NonoTop(title: 'scanner_login_title'.tr(), subtitle: 'scanner_login_subtitle'.tr()),
      const SizedBox(height: 18),
      NonoCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('scanner_login_heading'.tr(), style: NonoTheme.h2),
            const SizedBox(height: 7),
            Text(
              'scanner_login_description'.tr(),
              style: NonoTheme.muted,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: NonoInput(label: 'scanner_login_name_label'.tr(), controller: name, hint: 'scanner_login_name_hint'.tr()),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: NonoInput(
                    label: 'scanner_login_nickname_label'.tr(),
                    controller: nickname,
                    hint: 'scanner_login_nickname_hint'.tr(),
                  ),
                ),
              ],
            ),
            NonoInput(
              label: 'scanner_login_phone_label'.tr(),
              controller: phone,
              hint: '010-9999-0000',
              keyboardType: TextInputType.phone,
            ),
            CheckboxListTile(
              value: verified,
              onChanged: (v) => setState(() => verified = v ?? false),
              activeColor: NonoTheme.coral,
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              title: Text(
                'scanner_login_checkbox_label'.tr(),
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  color: NonoTheme.charcoal,
                ),
              ),
            ),
            const SizedBox(height: 12),
            NonoButton(
              text: 'scanner_login_submit_button'.tr(),
              icon: Icons.qr_code_scanner,
              onTap: () {
                if (!verified) {
                  nonoToast(context, 'scanner_login_toast_need_verify'.tr());
                  return;
                }
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const QrScanPage()),
                );
              },
            ),
          ],
        ),
      ),
    ],
  );
}
