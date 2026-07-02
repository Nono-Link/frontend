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
    const NonoTop(title: '담당자 로그인', subtitle: '재능 나눔이 등록과 명함 발급을 진행합니다'),
    const SizedBox(height: 20),
    Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: NonoTheme.lineSoft, borderRadius: BorderRadius.circular(16)), child: Row(children: [
      _tab('로그인', loginMode, () => setState(() => loginMode = true)),
      const SizedBox(width: 8),
      _tab('회원가입', !loginMode, () => setState(() => loginMode = false)),
    ])),
    const SizedBox(height: 16),
    NonoCard(child: loginMode ? _login(context) : _signup(context)),
  ]);
  Widget _tab(String t, bool active, VoidCallback f) => Expanded(child: GestureDetector(onTap: f, child: Container(alignment: Alignment.center, padding: const EdgeInsets.symmetric(vertical: 13), decoration: BoxDecoration(color: active ? NonoTheme.paper : Colors.transparent, borderRadius: BorderRadius.circular(12)), child: Text(t, style: TextStyle(fontWeight: FontWeight.w900, color: active ? NonoTheme.charcoal : NonoTheme.charcoalSoft)))));
  Widget _login(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text('담당자 계정으로 로그인', style: NonoTheme.h2), const SizedBox(height: 8),
    Text('소속된 기관 또는 봉사자 계정으로 접속합니다.', style: NonoTheme.muted), const SizedBox(height: 18),
    NonoInput(label: '아이디', controller: id, hint: 'gangbuk_volunteer'),
    NonoInput(label: '비밀번호', controller: pw, hint: '비밀번호 입력', obscure: true),
    NonoButton(text: '업무 홈으로 이동', icon: Icons.login, onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const StaffHomePage()))),
    const SizedBox(height: 14),
    NonoButton(text: '회원가입하기', icon: Icons.person_add, secondary: true, onTap: () => setState(() => loginMode = false)),
  ]);
  Widget _signup(BuildContext context) {
    if (done) return Column(children: [const Text('🎉', style: TextStyle(fontSize: 50)), Text('계정 생성 완료', style: NonoTheme.h2), const SizedBox(height: 8), Text('${name.text} 님 계정이 생성되었습니다.', textAlign: TextAlign.center, style: NonoTheme.muted), const SizedBox(height: 18), NonoButton(text: '로그인 화면으로', onTap: () => setState(() => loginMode = true))]);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('담당자 계정 만들기', style: NonoTheme.h2), const SizedBox(height: 12),
      Row(children: [Expanded(child: _role('🏛️', '지자체 직원', 'STAFF')), const SizedBox(width: 10), Expanded(child: _role('🤝', '자원봉사자', 'VOLUNTEER'))]),
      NonoInput(label: '아이디', controller: id, hint: '영문·숫자 4자 이상'),
      NonoInput(label: '비밀번호', controller: pw, hint: '8자 이상', obscure: true),
      NonoInput(label: '이름', controller: name, hint: '홍길동'),
      NonoInput(label: '전화번호', controller: phone, hint: '010-1234-5678'),
      NonoButton(text: '회원가입 완료', icon: Icons.check, onTap: () => setState(() => done = true)),
      const SizedBox(height: 14),
      const NonoInfo(icon: '👵', title: '재능 나눔이 계정은 담당자가 등록합니다', body: '신청서 확인 후 재능 나눔이용 간단 인증 계정이 생성됩니다.'),
    ]);
  }
  Widget _role(String e, String title, String value) => GestureDetector(onTap: () => setState(() => role = value), child: Container(margin: const EdgeInsets.only(bottom: 15), padding: const EdgeInsets.all(13), decoration: BoxDecoration(color: role == value ? NonoTheme.coral.withValues(alpha: .08) : NonoTheme.cream, borderRadius: BorderRadius.circular(15), border: Border.all(color: role == value ? NonoTheme.coral : NonoTheme.line, width: 2)), child: Column(children: [Text(e, style: const TextStyle(fontSize: 26)), const SizedBox(height: 6), Text(title, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w900))])));
}
