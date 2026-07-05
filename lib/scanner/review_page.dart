import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../common/nono_theme.dart';
import '../common/widgets/nono_widgets.dart';

class ReviewPage extends StatefulWidget { const ReviewPage({super.key}); @override State<ReviewPage> createState()=>_ReviewPageState(); }
class _ReviewPageState extends State<ReviewPage> { int score=5; final review=TextEditingController(text:'scanner_review_default_text'.tr());
  @override Widget build(BuildContext context)=>NonoPage(children:[
    NonoTop(title:'scanner_review_title'.tr(), subtitle:'scanner_review_subtitle'.tr()), const SizedBox(height:18),
    NonoCard(child: Column(crossAxisAlignment:CrossAxisAlignment.start, children:[
      Text('scanner_review_heading'.tr(), style:NonoTheme.h2), const SizedBox(height:14),
      Row(mainAxisAlignment:MainAxisAlignment.center, children:List.generate(5, (i)=>IconButton(onPressed:()=>setState(()=>score=i+1), icon:Icon(i<score?Icons.star:Icons.star_border, color:NonoTheme.coral, size:36)))), const SizedBox(height:10),
      Center(child:NonoChip(text:'scanner_review_manner_temp_chip'.tr(), color:NonoTheme.green)), const SizedBox(height:20),
      NonoInput(label:'scanner_review_label'.tr(), controller:review, hint:'scanner_review_hint'.tr(), maxLines:4),
      NonoButton(text:'scanner_review_submit_button'.tr(), icon:Icons.check, green:true, onTap:(){ nonoToast(context, 'scanner_review_toast_success'.tr()); Navigator.popUntil(context, (r)=>r.isFirst); }),
    ])),
    const SizedBox(height:16), NonoInfo(icon:'🛡️', title:'scanner_review_noshow_info_title'.tr(), body:'scanner_review_noshow_info_body'.tr()),
  ]);
}
