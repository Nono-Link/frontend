import 'package:flutter/material.dart';
import '../common/nono_theme.dart';
import '../common/widgets/nono_widgets.dart';
import 'senior_chat_page.dart';

class SeniorMatchPage extends StatelessWidget { const SeniorMatchPage({super.key});
  @override Widget build(BuildContext context)=>NonoPage(children:[
    const NonoTop(title:'매칭 요청', subtitle:'신원 확인된 이웃의 요청만 표시됩니다'), const SizedBox(height:18),
    NonoCard(child: Column(crossAxisAlignment:CrossAxisAlignment.start, children:[
      const Row(children:[CircleAvatar(radius:32, backgroundColor:NonoTheme.lineSoft, child:Text('민수', style:TextStyle(fontWeight:FontWeight.w900))), SizedBox(width:14), Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start, children:[Text('박민수 님', style:NonoTheme.h2), SizedBox(height:4), Text('신원 확인 완료 · 매너온도 37.8℃', style:NonoTheme.muted)]))]),
      const SizedBox(height:20), const NonoInfo(icon:'💬', title:'요청 내용', body:'화분을 자꾸 시들게 해서요. 선생님께 물 주는 방법을 배우고 싶어요.', color:NonoTheme.green),
      const SizedBox(height:18), NonoButton(text:'수락하고 채팅하기', icon:Icons.check, green:true, onTap:()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const SeniorChatPage()))),
      const SizedBox(height:10), NonoButton(text:'이번에는 거절하기', icon:Icons.close, secondary:true, onTap:()=>nonoToast(context, '요청을 거절했습니다.')),
    ])),
    const SizedBox(height:16), const NonoInfo(icon:'🛡️', title:'안전 장치', body:'스캐너는 로그인·신원 확인 후에만 요청할 수 있고, 노쇼나 불편 신고가 있으면 평판이 내려갑니다.'),
  ]);
}
