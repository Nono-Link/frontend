import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../common/nono_theme.dart';
import '../common/widgets/nono_widgets.dart';
import '../staff/staff_home_page.dart';

class LoginExpertPage extends StatefulWidget { const LoginExpertPage({super.key}); @override State<LoginExpertPage> createState() => _LoginExpertPageState(); }
class _LoginExpertPageState extends State<LoginExpertPage> {
  bool loginMode = true, done = false;
  String role = 'STAFF';
  final id = TextEditingController(); final pw = TextEditingController(); final name = TextEditingController(); final phone = TextEditingController();
  @override
  Widget build(BuildContext context) => NonoPage(children: [
    NonoTop(title: 'login_expert_top_title'.tr(), subtitle: 'login_expert_top_subtitle'.tr()),
    const SizedBox(height: 20),
    Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: NonoTheme.lineSoft, borderRadius: BorderRadius.circular(16)), child: Row(children: [
      _tab('login_expert_tab_login'.tr(), loginMode, () => setState(() => loginMode = true)),
      const SizedBox(width: 8),
      _tab('login_expert_tab_signup'.tr(), !loginMode, () => setState(() => loginMode = false)),
    ])),
    const SizedBox(height: 16),
    NonoCard(child: loginMode ? _login(context) : _signup(context)),
  ]);
  Widget _tab(String t, bool active, VoidCallback f) => Expanded(child: GestureDetector(onTap: f, child: Container(alignment: Alignment.center, padding: const EdgeInsets.symmetric(vertical: 13), decoration: BoxDecoration(color: active ? NonoTheme.paper : Colors.transparent, borderRadius: BorderRadius.circular(12)), child: Text(t, style: TextStyle(fontWeight: FontWeight.w900, color: active ? NonoTheme.charcoal : NonoTheme.charcoalSoft)))));
  Widget _login(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text('login_expert_login_heading'.tr(), style: NonoTheme.h2), const SizedBox(height: 8),
    Text('login_expert_login_description'.tr(), style: NonoTheme.muted), const SizedBox(height: 18),
    NonoInput(label: 'login_expert_id_label'.tr(), controller: id, hint: 'gangbuk_volunteer'),
    NonoInput(label: 'login_expert_password_label'.tr(), controller: pw, hint: 'login_expert_login_password_hint'.tr(), obscure: true),
    NonoButton(text: 'login_expert_login_submit_button'.tr(), icon: Icons.login, onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const StaffHomePage()))),
    const SizedBox(height: 14),
    NonoButton(text: 'login_expert_go_signup_button'.tr(), icon: Icons.person_add, secondary: true, onTap: () => setState(() => loginMode = false)),
  ]);
  Widget _signup(BuildContext context) {
    if (done) return Column(children: [const Text('🎉', style: TextStyle(fontSize: 50)), Text('login_expert_signup_done_title'.tr(), style: NonoTheme.h2), const SizedBox(height: 8), Text('login_expert_signup_done_message'.tr(namedArgs: {'name': name.text}), textAlign: TextAlign.center, style: NonoTheme.muted), const SizedBox(height: 18), NonoButton(text: 'login_expert_signup_done_button'.tr(), onTap: () => setState(() => loginMode = true))]);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('login_expert_signup_heading'.tr(), style: NonoTheme.h2), const SizedBox(height: 12),
      Row(children: [Expanded(child: _role('🏛️', 'login_expert_role_staff'.tr(), 'STAFF')), const SizedBox(width: 10), Expanded(child: _role('🤝', 'login_expert_role_volunteer'.tr(), 'VOLUNTEER'))]),
      NonoInput(label: 'login_expert_id_label'.tr(), controller: id, hint: 'login_expert_signup_id_hint'.tr()),
      NonoInput(label: 'login_expert_password_label'.tr(), controller: pw, hint: 'login_expert_signup_password_hint'.tr(), obscure: true),
      NonoInput(label: 'login_expert_name_label'.tr(), controller: name, hint: 'login_expert_name_hint'.tr()),
      NonoInput(label: 'login_expert_phone_label'.tr(), controller: phone, hint: '010-1234-5678'),
      NonoButton(text: 'login_expert_signup_submit_button'.tr(), icon: Icons.check, onTap: () => setState(() => done = true)),
      const SizedBox(height: 14),
      NonoInfo(icon: '👵', title: 'login_expert_info_title'.tr(), body: 'login_expert_info_body'.tr()),
    ]);
  }
  Widget _role(String e, String title, String value) => GestureDetector(onTap: () => setState(() => role = value), child: Container(margin: const EdgeInsets.only(bottom: 15), padding: const EdgeInsets.all(13), decoration: BoxDecoration(color: role == value ? NonoTheme.coral.withValues(alpha: .08) : NonoTheme.cream, borderRadius: BorderRadius.circular(15), border: Border.all(color: role == value ? NonoTheme.coral : NonoTheme.line, width: 2)), child: Column(children: [Text(e, style: const TextStyle(fontSize: 26)), const SizedBox(height: 6), Text(title, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w900))])));
}
