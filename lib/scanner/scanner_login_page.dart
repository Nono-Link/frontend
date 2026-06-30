import 'package:flutter/material.dart';
import '../common/nono_theme.dart';
import '../common/widgets/nono_widgets.dart';
import 'qr_scan_page.dart';

class ScannerLoginPage extends StatefulWidget { const ScannerLoginPage({super.key}); @override State<ScannerLoginPage> createState()=>_ScannerLoginPageState(); }
class _ScannerLoginPageState extends State<ScannerLoginPage> { final name=TextEditingController(text:'박민수'), phone=TextEditingController(text:'010-9999-0000'); bool verified=false;
  @override Widget build(BuildContext context)=>NonoPage(children:[
    const NonoTop(title:'이웃 로그인', subtitle:'QR 스캔 전 본인 확인을 진행합니다'), const SizedBox(height:18),
    NonoCard(child: Column(crossAxisAlignment:CrossAxisAlignment.start, children:[
      Text('이웃 인증', style:NonoTheme.h2), const SizedBox(height:7), Text('안전한 매칭을 위해 본인 확인이 완료된 사용자만 QR 명함을 확인할 수 있습니다.', style:NonoTheme.muted), const SizedBox(height:20),
      NonoInput(label:'이름', controller:name, hint:'박민수'), NonoInput(label:'전화번호', controller:phone, hint:'010-9999-0000', keyboardType:TextInputType.phone),
      CheckboxListTile(value:verified, onChanged:(v)=>setState(()=>verified=v??false), activeColor:NonoTheme.coral, controlAffinity:ListTileControlAffinity.leading, contentPadding:EdgeInsets.zero, title:const Text('휴대폰 본인 확인 완료', style:TextStyle(fontWeight:FontWeight.w900, color:NonoTheme.charcoal))),
      const SizedBox(height:12), NonoButton(text:'인증 후 QR 스캔하기', icon:Icons.qr_code_scanner, onTap:(){ if(!verified){ nonoToast(context, '본인확인 체크 후 진행해 주세요.'); return; } Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const QrScanPage())); }),
    ])),
  ]);
}
