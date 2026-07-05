import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../common/nono_theme.dart';
import '../common/widgets/nono_widgets.dart';

class CardPreviewPage extends StatelessWidget { const CardPreviewPage({super.key});
  @override Widget build(BuildContext context) => NonoPage(children: [
    NonoTop(title:'staff_card_preview_title'.tr(), subtitle:'staff_card_preview_subtitle'.tr()),
    const SizedBox(height:18),
    NonoCard(child: Column(children: [
      Text('staff_card_preview_mood_title'.tr(), style:const TextStyle(color:NonoTheme.coral, fontWeight:FontWeight.w900, fontSize:18)), const SizedBox(height:10),
      Text('staff_card_preview_name'.tr(), style:const TextStyle(color:NonoTheme.charcoal, fontSize:34, fontWeight:FontWeight.w900)), const SizedBox(height:8),
      Wrap(alignment:WrapAlignment.center, spacing:8, runSpacing:8, children:[NonoChip(text:'staff_talent_hobby_label'.tr()), NonoChip(text:'staff_card_preview_chip_career'.tr()), NonoChip(text:'staff_card_preview_chip_time'.tr())]), const SizedBox(height:22),
      Container(padding:const EdgeInsets.all(20), decoration:BoxDecoration(color:NonoTheme.cream, borderRadius:BorderRadius.circular(20), border:Border.all(color:NonoTheme.line, width:1.5)), child:Column(children:[const Icon(Icons.qr_code_2, size:112, color:NonoTheme.charcoal), const SizedBox(height:8), Text('staff_card_preview_qr_label'.tr(), style:const TextStyle(fontWeight:FontWeight.w900)), Text('staff_card_preview_qr_desc'.tr(), textAlign:TextAlign.center, style:NonoTheme.muted)])),
      const SizedBox(height:20), Text('staff_card_preview_intro_quote'.tr(), textAlign:TextAlign.center, style:const TextStyle(fontSize:18, height:1.45, fontWeight:FontWeight.w800)),
    ])),
    const SizedBox(height:16), NonoInfo(icon:'🛡️', title:'staff_card_preview_safety_info_title'.tr(), body:'staff_card_preview_safety_info_body'.tr()),
    const SizedBox(height:16), NonoButton(text:'staff_card_preview_issue_button'.tr(), icon:Icons.check_circle, green:true, onTap:()=>nonoToast(context, 'staff_card_preview_toast_issued'.tr())),
  ]);
}
