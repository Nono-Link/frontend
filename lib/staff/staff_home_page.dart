import 'package:flutter/material.dart';
import '../common/nono_theme.dart';
import '../common/widgets/nono_widgets.dart';
import 'application_ocr_page.dart';
import 'application_review_page.dart';
import 'card_preview_page.dart';

class StaffHomePage extends StatelessWidget { const StaffHomePage({super.key});
  @override Widget build(BuildContext context) => NonoPage(children: [
    const NonoTop(title: '담당자 업무 홈', subtitle: '신청서 등록부터 명함 발급까지 진행합니다', home: true),
    const SizedBox(height: 18),
    const NonoInfo(icon: '✍️', title: '오늘의 등록 절차', body: '신청서 촬영 → 내용 확인 → 안전 동의 확인 → QR 명함 발급', color: NonoTheme.coral),
    const SizedBox(height: 16),
    _step(context, '1', '신청서 OCR 등록', '재능 나눔이가 작성한 종이 신청서를 촬영하거나 파일로 등록합니다.', Icons.document_scanner, const ApplicationOcrPage()),
    const SizedBox(height: 14),
    _step(context, '2', '신청서 내용 확인', '불러온 성함, 재능, 활동 선호, 동의 항목을 최종 확인합니다.', Icons.fact_check, const ApplicationReviewPage()),
    const SizedBox(height: 14),
    _step(context, '3', '명함 발급', '신원 확인된 재능 배움이만 확인할 수 있는 QR 명함을 발급합니다.', Icons.badge, const CardPreviewPage()),
  ]);
  Widget _step(BuildContext context, String n, String title, String desc, IconData icon, Widget page) => NonoCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Row(children: [CircleAvatar(backgroundColor: NonoTheme.coral, child: Text(n, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900))), const SizedBox(width: 12), Icon(icon, color: NonoTheme.coral), const SizedBox(width: 8), Expanded(child: Text(title, style: NonoTheme.h2))]),
    const SizedBox(height: 10), Text(desc, style: NonoTheme.body), const SizedBox(height: 16),
    NonoButton(text: '$title 진행하기', icon: Icons.arrow_forward, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => page))),
  ]));
}
