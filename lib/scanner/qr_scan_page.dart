import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../common/nono_theme.dart';
import '../common/widgets/nono_widgets.dart';
import 'scanner_match_page.dart';

class QrScanPage extends StatelessWidget { const QrScanPage({super.key});
  @override Widget build(BuildContext context)=>NonoPage(children:[
    NonoTop(title:'scanner_qr_title'.tr(), subtitle:'scanner_qr_subtitle'.tr()), const SizedBox(height:18),
    NonoCard(child: Column(children:[
      Container(height:310, width:double.infinity, decoration:BoxDecoration(color:NonoTheme.charcoal, borderRadius:BorderRadius.circular(22)), child:Stack(alignment:Alignment.center, children:[const Icon(Icons.qr_code_scanner, color:Colors.white70, size:120), Positioned(top:30, left:30, right:30, child:Container(height:3, color:NonoTheme.coral)), Positioned(bottom:28, child:Text('scanner_qr_guide_text'.tr(), style:const TextStyle(color:Colors.white, fontWeight:FontWeight.w900, fontSize:17)))])),
      const SizedBox(height:18), NonoButton(text:'scanner_qr_confirm_button'.tr(), icon:Icons.check_circle, onTap:()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>const ScannerMatchPage()))),
    ])),
    const SizedBox(height:16), NonoInfo(icon:'🛡️', title:'scanner_qr_safe_info_title'.tr(), body:'scanner_qr_safe_info_body'.tr()),
  ]);
}
