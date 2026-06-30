import 'package:flutter/material.dart';
import '../common/nono_theme.dart';
import '../common/widgets/nono_widgets.dart';
import 'senior_match_page.dart';
import 'senior_chat_page.dart';

class SeniorHomePage extends StatelessWidget { const SeniorHomePage({super.key});
  @override Widget build(BuildContext context)=>NonoPage(children:[
    const NonoTop(title:'어르신 홈', subtitle:'내 명함과 새 요청을 바로 확인합니다', home:true), const SizedBox(height:18),
    NonoCard(child: Column(children:const [Text('🌿', style:TextStyle(fontSize:54)), SizedBox(height:8), Text('김영자 님의 재능 명함', style:TextStyle(fontSize:25, fontWeight:FontWeight.w900, color:NonoTheme.charcoal)), SizedBox(height:10), Text('작은 화분을 오래 건강하게 키우는 법을 알려드려요.', textAlign:TextAlign.center, style:TextStyle(fontSize:19, height:1.45, fontWeight:FontWeight.w800)), SizedBox(height:14), Wrap(alignment:WrapAlignment.center, spacing:8, runSpacing:8, children:[NonoChip(text:'원예'), NonoChip(text:'평일 오후'), NonoChip(text:'주민센터')])])),
    const SizedBox(height:16), NonoButton(text:'새 매칭 요청 확인', icon:Icons.favorite, onTap:()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>const SeniorMatchPage()))),
    const SizedBox(height:12), NonoButton(text:'채팅함 열기', icon:Icons.chat_bubble, secondary:true, onTap:()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>const SeniorChatPage()))),
    const SizedBox(height:16), const NonoInfo(icon:'🩵', title:'주요 메뉴', body:'명함 확인, 매칭 수락, 빠른 답장 채팅을 큰 버튼으로 이용할 수 있습니다.'),
  ]);
}
