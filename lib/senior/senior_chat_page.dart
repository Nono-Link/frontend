import 'package:flutter/material.dart';
import '../common/nono_theme.dart';
import '../common/widgets/nono_widgets.dart';

class SeniorChatPage extends StatefulWidget { const SeniorChatPage({super.key}); @override State<SeniorChatPage> createState()=>_SeniorChatPageState(); }
class _SeniorChatPageState extends State<SeniorChatPage> { final msgs=[['안녕하세요! 화분 가꾸기 배우고 싶어서 연락드렸어요.','0'], ['네, 좋아요. 주민센터에서 만나면 될까요?','1']];
  void add(String t)=>setState(()=>msgs.add([t,'1']));
  @override Widget build(BuildContext context)=>NonoPage(children:[
    const NonoTop(title:'간단 채팅', subtitle:'자주 쓰는 답장을 눌러 편하게 대화합니다'), const SizedBox(height:18),
    NonoCard(child: Column(children:[for(final m in msgs) Align(alignment:m[1]=='1'?Alignment.centerRight:Alignment.centerLeft, child:Container(margin:const EdgeInsets.only(bottom:10), padding:const EdgeInsets.symmetric(horizontal:15, vertical:12), constraints:const BoxConstraints(maxWidth:360), decoration:BoxDecoration(color:m[1]=='1'?NonoTheme.coral:NonoTheme.lineSoft, borderRadius:BorderRadius.circular(18)), child:Text(m[0], style:TextStyle(color:m[1]=='1'?Colors.white:NonoTheme.charcoal, fontSize:17, height:1.4, fontWeight:FontWeight.w800))))])),
    const SizedBox(height:16), Text('빠른 답장', style:NonoTheme.h2), const SizedBox(height:10),
    Wrap(spacing:9, runSpacing:9, children:['네, 좋아요','주민센터에서 만나요','오후가 좋아요','다시 연락드릴게요'].map((r)=>ElevatedButton(onPressed:()=>add(r), style:ElevatedButton.styleFrom(backgroundColor:NonoTheme.paper, foregroundColor:NonoTheme.charcoal, elevation:0, side:const BorderSide(color:NonoTheme.line, width:1.5), padding:const EdgeInsets.symmetric(horizontal:15, vertical:13)), child:Text(r, style:const TextStyle(fontWeight:FontWeight.w900)))).toList()),
    const SizedBox(height:14), NonoButton(text:'음성으로 말하기', icon:Icons.mic, secondary:true, onTap:()=>nonoToast(context, '음성 입력을 시작합니다.')),
  ]);
}
