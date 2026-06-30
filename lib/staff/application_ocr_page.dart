import 'package:flutter/material.dart';
import '../common/nono_theme.dart';
import '../common/widgets/nono_widgets.dart';
import 'application_review_page.dart';

class ApplicationOcrPage extends StatefulWidget { const ApplicationOcrPage({super.key}); @override State<ApplicationOcrPage> createState() => _ApplicationOcrPageState(); }
class _ApplicationOcrPageState extends State<ApplicationOcrPage> { bool scanned = false;
  @override Widget build(BuildContext context) => NonoPage(children: [
    const NonoTop(title: '신청서 OCR 등록', subtitle: '종이 신청서를 촬영해 명함 정보를 불러옵니다'),
    const SizedBox(height: 18),
    NonoCard(child: Column(children: [
      Container(height: 300, width: double.infinity, padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: NonoTheme.cream, borderRadius: BorderRadius.circular(20), border: Border.all(color: scanned ? NonoTheme.green : NonoTheme.line, width: 2)), child: scanned ? _done() : _camera()),
      const SizedBox(height: 18),
      NonoButton(text: scanned ? '인식 결과 확인하기' : '신청서 촬영하기', icon: scanned ? Icons.fact_check : Icons.camera_alt, green: scanned, onTap: () { if (scanned) { Navigator.push(context, MaterialPageRoute(builder: (_) => const ApplicationReviewPage())); } else { setState(() => scanned = true); nonoToast(context, '신청서 인식이 완료되었습니다.'); }}),
      const SizedBox(height: 10),
      NonoButton(text: '파일에서 업로드', icon: Icons.upload_file, secondary: true, onTap: () { setState(() => scanned = true); nonoToast(context, '신청서 파일이 등록되었습니다.'); }),
    ])),
    const SizedBox(height: 14),
    const NonoInfo(icon: '🩵', title: '등록 안내', body: '불러온 신청서 내용은 담당자가 최종 확인한 뒤 명함에 반영됩니다.'),
  ]);
  Widget _camera() => const Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.document_scanner, size: 80, color: NonoTheme.charcoalSoft), SizedBox(height: 14), Text('신청서를 화면 안에 맞춰주세요', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)), SizedBox(height: 6), Text('신청서 모서리를 맞추면\n정보를 자동으로 불러옵니다.', textAlign: TextAlign.center, style: NonoTheme.muted)]);
  Widget _done() => const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Icon(Icons.check_circle, color: NonoTheme.green), SizedBox(width: 8), Text('OCR 인식 완료', style: TextStyle(color: NonoTheme.green, fontSize: 20, fontWeight: FontWeight.w900))]), SizedBox(height: 18), Text('성함  김영자', style: NonoTheme.body), Text('재능  원예 · 화분 가꾸기', style: NonoTheme.body), Text('경력  20년', style: NonoTheme.body), Text('활동  평일 오후 · 주민센터 · 1:1', style: NonoTheme.body), Spacer(), Text('담당자가 내용을 확인한 뒤 명함에 반영합니다.', style: NonoTheme.muted)]);
}
