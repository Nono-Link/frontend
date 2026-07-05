import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../common/nono_theme.dart';
import '../common/widgets/nono_widgets.dart';
import '../common/matching_store.dart';
import 'senior_chat_page.dart';

class SeniorMatchPage extends StatelessWidget { const SeniorMatchPage({super.key});
  @override Widget build(BuildContext context) {
    final req = MatchingStore.instance.currentRequest;
    return NonoPage(children:[
      NonoTop(title:'senior_match_title'.tr(), subtitle:'senior_match_subtitle'.tr()), const SizedBox(height:18),
      NonoCard(child: Column(crossAxisAlignment:CrossAxisAlignment.start, children:[
        Row(children:[CircleAvatar(radius:32, backgroundColor:NonoTheme.lineSoft, child:Text('senior_match_avatar_initial'.tr(), style:const TextStyle(fontWeight:FontWeight.w900))), const SizedBox(width:14), Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start, children:[Text('senior_match_requester_name'.tr(), style:NonoTheme.h2), const SizedBox(height:4), Text('senior_match_requester_status'.tr(), style:NonoTheme.muted)]))]),
        const SizedBox(height:20), NonoInfo(icon:'💬', title:'senior_match_request_info_title'.tr(), body:'senior_match_request_info_body'.tr(), color:NonoTheme.green),
        if (req != null) ...[
          const SizedBox(height:12),
          NonoInfo(icon:'🗓️', title:'senior_match_proposed_time_title'.tr(), body:'senior_match_proposed_time_body'.tr(namedArgs: {'place': req.place, 'day': req.day, 'timeSlot': req.timeSlot}), color:NonoTheme.navy),
        ],
        const SizedBox(height:18), NonoButton(text:'senior_match_accept_button'.tr(), icon:Icons.check, green:true, onTap:(){
          MatchingStore.instance.respondToRequest(accept:true);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const SeniorChatPage()));
        }),
        const SizedBox(height:10), NonoButton(text:'senior_match_reject_button'.tr(), icon:Icons.close, secondary:true, onTap:(){
          MatchingStore.instance.respondToRequest(accept:false);
          nonoToast(context, 'senior_match_toast_rejected'.tr());
        }),
      ])),
      const SizedBox(height:16), NonoInfo(icon:'🛡️', title:'senior_match_safety_info_title'.tr(), body:'senior_match_safety_info_body'.tr()),
    ]);
  }
}
