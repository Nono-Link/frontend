import 'package:flutter/material.dart';
import '../common/nono_theme.dart';
import '../common/widgets/nono_widgets.dart';
import 'match_request_page.dart';

class ScannerMatchPage extends StatelessWidget { const ScannerMatchPage({super.key});
  @override Widget build(BuildContext context)=>NonoPage(children:[
    const NonoTop(title:'명함 확인 및 매칭 신청', subtitle:'QR로 연결된 재능 명함을 확인합니다'), const SizedBox(height:18),
    NonoCard(child: Column(children:[
      const Text('🌿', style:TextStyle(fontSize:56)), const SizedBox(height:8), const Text('김영자 님', style:TextStyle(fontSize:30, fontWeight:FontWeight.w900, color:NonoTheme.charcoal)), const SizedBox(height:8),
      const Text('화분 가꾸기 · 경력 20년', style:TextStyle(color:NonoTheme.coral, fontSize:18, fontWeight:FontWeight.w900)), const SizedBox(height:16),
      const Text('작은 화분을 오래 건강하게 키우는 법을 알려드려요.', textAlign:TextAlign.center, style:TextStyle(fontSize:18, height:1.45, fontWeight:FontWeight.w800)), const SizedBox(height:18),
      const Wrap(spacing:8, runSpacing:8, alignment:WrapAlignment.center, children:[NonoChip(text:'평일 오후'), NonoChip(text:'주민센터'), NonoChip(text:'1:1')]), const SizedBox(height:18),
      NonoButton(text:'매칭 신청하기', icon:Icons.favorite, onTap:()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>const MatchRequestPage()))),
    ])),
    const SizedBox(height:16), const NonoInfo(icon:'🌡️', title:'평판 시스템', body:'만남 후 후기와 온도가 반영됩니다. 불참이나 신고가 누적되면 매칭 신청이 제한됩니다.', color:NonoTheme.green),
  ]);
}
