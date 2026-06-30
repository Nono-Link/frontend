import 'package:flutter/material.dart';
import '../common/nono_theme.dart';
import '../common/widgets/nono_widgets.dart';

class ReviewPage extends StatefulWidget { const ReviewPage({super.key}); @override State<ReviewPage> createState()=>_ReviewPageState(); }
class _ReviewPageState extends State<ReviewPage> { int score=5; final review=TextEditingController(text:'친절하게 알려주셔서 화분 관리가 쉬워졌어요!');
  @override Widget build(BuildContext context)=>NonoPage(children:[
    const NonoTop(title:'후기 작성', subtitle:'만남 경험을 남겨 신뢰를 쌓습니다'), const SizedBox(height:18),
    NonoCard(child: Column(crossAxisAlignment:CrossAxisAlignment.start, children:[
      Text('김영자 님과의 만남은 어땠나요?', style:NonoTheme.h2), const SizedBox(height:14),
      Row(mainAxisAlignment:MainAxisAlignment.center, children:List.generate(5, (i)=>IconButton(onPressed:()=>setState(()=>score=i+1), icon:Icon(i<score?Icons.star:Icons.star_border, color:NonoTheme.coral, size:36)))), const SizedBox(height:10),
      const Center(child:NonoChip(text:'매너온도 +0.4℃', color:NonoTheme.green)), const SizedBox(height:20),
      NonoInput(label:'후기', controller:review, hint:'후기를 적어주세요', maxLines:4),
      NonoButton(text:'후기 등록하기', icon:Icons.check, green:true, onTap:(){ nonoToast(context, '후기가 등록되었습니다.'); Navigator.popUntil(context, (r)=>r.isFirst); }),
    ])),
    const SizedBox(height:16), const NonoInfo(icon:'🛡️', title:'노쇼 방지', body:'불참·신고가 누적되면 온도가 하락하고, 일정 이하에서는 매칭 신청이 제한됩니다.'),
  ]);
}
