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
      const NonoTop(title: '재능 나눔이 간단 인증', subtitle: '등록된 전화번호로 내 명함을 확인합니다'),
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
            const Text(
              '내 재능 명함 확인',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.w900,
                color: NonoTheme.charcoal,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '담당자가 등록한 재능 명함을\n전화번호로 안전하게 확인합니다.',
              textAlign: TextAlign.center,
              style: NonoTheme.body.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: NonoInput(label: '이름', controller: name, hint: '홍길동'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: NonoInput(
                    label: '별명',
                    controller: nickname,
                    hint: '나눔이',
                  ),
                ),
              ],
            ),
            NonoInput(
              label: '전화번호',
              controller: phone,
              hint: '010-1234-5678',
              keyboardType: TextInputType.phone,
            ),
            if (sent)
              NonoInput(
                label: '인증번호',
                controller: code,
                hint: '123456',
                keyboardType: TextInputType.number,
              ),
            NonoButton(
              text: sent ? '내 명함 보러 가기' : '인증번호 받기',
              icon: sent ? Icons.badge : Icons.sms,
              onTap: () {
                if (!sent) {
                  setState(() => sent = true);
                  nonoToast(context, '인증번호를 보냈습니다.');
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const MyTalentCardScreen(code: '483920')),
                  );
                }
              },
            ),
            const SizedBox(height: 16),
            const NonoInfo(
              icon: '✍️',
              title: '입력은 최소화했습니다',
              body: '재능·경력·활동 선호는 이미 등록되어 있어, 앱에서는 확인과 수락만 진행합니다.',
              color: NonoTheme.coral,
            ),
          ],
        ),
      ),
    ],
  );
}
