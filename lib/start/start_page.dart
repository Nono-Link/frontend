import 'package:flutter/material.dart';
import '../common/nono_theme.dart';
import '../common/widgets/nono_widgets.dart';
import '../login_expert/login_expert_page.dart';
import '../senior/senior_login_page.dart';
import '../scanner/scanner_login_page.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});
  @override
  Widget build(BuildContext context) => NonoPage(maxWidth: 640, children: [
    const NonoHeader(title: '노노링크', subtitle: '종이 신청서에서 시작해 안전한 재능 배움이 매칭까지 연결합니다'),
    const SizedBox(height: 22),
    const NonoInfo(icon: '🩵', title: '안전한 재능 연결', body: '재능 나눔이는 손글씨 신청서로 재능을 등록하고, 앱에서는 명함 확인·매칭 수락·채팅만 이용합니다.', color: NonoTheme.coral),
    const SizedBox(height: 18),
    _RoleCard(emoji: '🏛️', title: '직원 / 봉사자', desc: '신청서 OCR 등록, 검수, 명함 발급', chips: const ['로그인', 'OCR 등록', '명함 발급'], page: const LoginExpertPage()),
    const SizedBox(height: 14),
    _RoleCard(emoji: '👵', title: '재능 나눔이', desc: '간단 인증, 내 명함 보기, 매칭 수락, 채팅', chips: const ['간단 인증', '내 명함', '채팅'], page: const SeniorLoginPage()),
    const SizedBox(height: 14),
    _RoleCard(emoji: '📱', title: '재능 배움이 / 스캐너', desc: '로그인, QR 스캔, 매칭 신청, 후기 작성', chips: const ['신원 확인', 'QR 스캔', '후기'], page: const ScannerLoginPage()),
  ]);
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({required this.emoji, required this.title, required this.desc, required this.chips, required this.page});
  final String emoji, title, desc;
  final List<String> chips;
  final Widget page;
  @override
  Widget build(BuildContext context) => NonoCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Row(children: [Text(emoji, style: const TextStyle(fontSize: 34)), const SizedBox(width: 12), Expanded(child: Text(title, style: NonoTheme.h2))]),
    const SizedBox(height: 8),
    Text(desc, style: NonoTheme.body),
    const SizedBox(height: 12),
    Wrap(spacing: 8, runSpacing: 8, children: chips.map((e) => NonoChip(text: e, color: NonoTheme.navy)).toList()),
    const SizedBox(height: 16),
    NonoButton(text: '$title 시작하기', icon: Icons.arrow_forward, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => page))),
  ]));
}
