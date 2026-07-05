import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../common/nono_theme.dart';
import '../common/widgets/nono_widgets.dart';
import 'match_request_page.dart';

class ScannerMatchPage extends StatelessWidget { const ScannerMatchPage({super.key});
  @override Widget build(BuildContext context)=>NonoPage(children:[
    NonoTop(title:'scanner_match_page_title'.tr(), subtitle:'scanner_match_page_subtitle'.tr()), const SizedBox(height:18),
    NonoCard(child: Column(children:[
      const Text('🌿', style:TextStyle(fontSize:56)), const SizedBox(height:8), Text('scanner_match_page_giver_name'.tr(), style:const TextStyle(fontSize:30, fontWeight:FontWeight.w900, color:NonoTheme.charcoal)), const SizedBox(height:8),
      Text('scanner_match_page_giver_tag'.tr(), style:const TextStyle(color:NonoTheme.coral, fontSize:18, fontWeight:FontWeight.w900)), const SizedBox(height:16),
      Text('scanner_match_page_giver_description'.tr(), textAlign:TextAlign.center, style:const TextStyle(fontSize:18, height:1.45, fontWeight:FontWeight.w800)), const SizedBox(height:18),
      Wrap(spacing:8, runSpacing:8, alignment:WrapAlignment.center, children:[NonoChip(text:'scanner_match_page_chip_afternoon'.tr()), NonoChip(text:'scanner_match_page_chip_place'.tr()), const NonoChip(text:'1:1')]), const SizedBox(height:18),
      NonoButton(text:'scanner_match_page_submit_button'.tr(), icon:Icons.favorite, onTap:()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>const MatchRequestPage()))),
    ])),
    const SizedBox(height:16), NonoInfo(icon:'🌡️', title:'scanner_match_page_reputation_info_title'.tr(), body:'scanner_match_page_reputation_info_body'.tr(), color:NonoTheme.green),
  ]);
}
