import 'package:flutter/material.dart';
import '../common/nono_theme.dart';
import '../common/widgets/nono_widgets.dart';
import 'scanner_match_page.dart';

class QrScanPage extends StatelessWidget { const QrScanPage({super.key});
  @override Widget build(BuildContext context)=>NonoPage(children:[
    const NonoTop(title:'보안 QR 스캔', subtitle:'재능 나눔자 명함을 앱에서 안전하게 확인합니다'), const SizedBox(height:18),
    NonoCard(child: Column(children:[
      Container(height:310, width:double.infinity, decoration:BoxDecoration(color:NonoTheme.charcoal, borderRadius:BorderRadius.circular(22)), child:Stack(alignment:Alignment.center, children:[const Icon(Icons.qr_code_scanner, color:Colors.white70, size:120), Positioned(top:30, left:30, right:30, child:Container(height:3, color:NonoTheme.coral)), const Positioned(bottom:28, child:Text('명함 QR을 화면 안에 맞춰주세요', style:TextStyle(color:Colors.white, fontWeight:FontWeight.w900, fontSize:17)))])),
      const SizedBox(height:18), NonoButton(text:'명함 확인하기', icon:Icons.check_circle, onTap:()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>const ScannerMatchPage()))),
    ])),
    const SizedBox(height:16), const NonoInfo(icon:'🛡️', title:'안전한 연결', body:'앱 밖 링크를 열지 않아 스미싱 위험을 줄이고, 본인 확인 이후에만 매칭 요청이 가능합니다.'),
  ]);
}
