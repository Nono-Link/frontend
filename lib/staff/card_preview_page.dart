import 'package:flutter/material.dart';
import '../common/nono_theme.dart';
import '../common/widgets/nono_widgets.dart';

class CardPreviewPage extends StatelessWidget { const CardPreviewPage({super.key});
  @override Widget build(BuildContext context) => NonoPage(children: [
    const NonoTop(title:'재능 명함', subtitle:'신원 확인된 사용자만 확인할 수 있는 명함입니다'),
    const SizedBox(height:18),
    NonoCard(child: Column(children: [
      const Text('따뜻한 원예 선생님', style:TextStyle(color:NonoTheme.coral, fontWeight:FontWeight.w900, fontSize:18)), const SizedBox(height:10),
      const Text('김영자 님', style:TextStyle(color:NonoTheme.charcoal, fontSize:34, fontWeight:FontWeight.w900)), const SizedBox(height:8),
      const Wrap(alignment:WrapAlignment.center, spacing:8, runSpacing:8, children:[NonoChip(text:'원예'), NonoChip(text:'경력 20년'), NonoChip(text:'평일 오후')]), const SizedBox(height:22),
      Container(padding:const EdgeInsets.all(20), decoration:BoxDecoration(color:NonoTheme.cream, borderRadius:BorderRadius.circular(20), border:Border.all(color:NonoTheme.line, width:1.5)), child:const Column(children:[Icon(Icons.qr_code_2, size:112, color:NonoTheme.charcoal), SizedBox(height:8), Text('보안 QR', style:TextStyle(fontWeight:FontWeight.w900)), Text('앱에서 인증된 사용자만 확인할 수 있습니다', textAlign:TextAlign.center, style:NonoTheme.muted)])),
      const SizedBox(height:20), const Text('“작은 화분을 오래 건강하게 키우는 법을 알려드려요.”', textAlign:TextAlign.center, style:TextStyle(fontSize:18, height:1.45, fontWeight:FontWeight.w800)),
    ])),
    const SizedBox(height:16), const NonoInfo(icon:'🛡️', title:'안전 설정', body:'전화번호와 상세 주소는 공개되지 않습니다. 신원 확인된 재능 배움이만 QR 명함을 확인하고 매칭을 신청할 수 있습니다.'),
    const SizedBox(height:16), NonoButton(text:'명함 발급 완료', icon:Icons.check_circle, green:true, onTap:()=>nonoToast(context, '명함 발급이 완료되었습니다.')),
  ]);
}
