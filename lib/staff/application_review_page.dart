import 'package:flutter/material.dart';
import '../common/nono_theme.dart';
import '../common/widgets/nono_widgets.dart';
import 'card_preview_page.dart';

class ApplicationReviewPage extends StatefulWidget { const ApplicationReviewPage({super.key}); @override State<ApplicationReviewPage> createState() => _ApplicationReviewPageState(); }
class _ApplicationReviewPageState extends State<ApplicationReviewPage> {
  final name = TextEditingController(text:'김영자'), age = TextEditingController(text:'70대'), town = TextEditingController(text:'성북동'), phone = TextEditingController(text:'010-1234-5678'), talent = TextEditingController(text:'원예, 화분 가꾸기'), career = TextEditingController(text:'20년'), intro = TextEditingController(text:'작은 화분을 오래 건강하게 키우는 법을 알려드립니다.'), pref = TextEditingController(text:'평일 오후 · 주민센터 · 1:1'), mood = TextEditingController(text:'따뜻한');
  bool privacy=true, qr=true, address=true, safety=true, idChecked=true, destroyed=false;
  @override Widget build(BuildContext context) => NonoPage(children: [
    const NonoTop(title: '신청서 내용 확인', subtitle: '명함에 반영될 정보와 안전 동의를 확인합니다'),
    const SizedBox(height: 16),
    const NonoInfo(icon:'🔎', title:'확인 필요', body:'명함 발급 전 담당자가 신청서 내용과 동의 항목을 최종 확인합니다.', color:NonoTheme.coral),
    const SizedBox(height: 16),
    NonoCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('기본·재능 정보', style: NonoTheme.h2), const SizedBox(height: 14),
      NonoInput(label:'성함', controller:name, hint:'성함'), NonoInput(label:'연령대', controller:age, hint:'70대'), NonoInput(label:'동네', controller:town, hint:'성북동'), NonoInput(label:'연락처', controller:phone, hint:'010-1234-5678'),
      NonoInput(label:'재능', controller:talent, hint:'원예'), NonoInput(label:'경력', controller:career, hint:'20년'), NonoInput(label:'한 줄 소개', controller:intro, hint:'저는 ... 를 잘합니다.', maxLines:3), NonoInput(label:'활동 선호', controller:pref, hint:'평일 오후 · 주민센터', maxLines:2), NonoInput(label:'명함 분위기', controller:mood, hint:'따뜻한'),
    ])),
    const SizedBox(height: 16),
    NonoCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('동의 · 안전 확인', style: NonoTheme.h2), const SizedBox(height: 8),
      _check('개인정보 활용 동의', privacy, (v)=>setState(()=>privacy=v)), _check('QR 명함 이용 동의', qr, (v)=>setState(()=>qr=v)), _check('주소 확인', address, (v)=>setState(()=>address=v)), _check('안전 서약 확인', safety, (v)=>setState(()=>safety=v)), _check('신분증 확인', idChecked, (v)=>setState(()=>idChecked=v)), _check('원본 신청서 파기 확인', destroyed, (v)=>setState(()=>destroyed=v)),
      const SizedBox(height: 12), NonoButton(text:'확인 완료하고 명함 발급', icon:Icons.badge, onTap:(){ if (!(privacy&&qr&&address&&safety&&idChecked)) { nonoToast(context, '필수 안전 항목을 확인해 주세요.'); return; } Navigator.push(context, MaterialPageRoute(builder: (_)=> const CardPreviewPage())); }),
    ])),
  ]);
  Widget _check(String t, bool v, ValueChanged<bool> f) => CheckboxListTile(value:v, onChanged:(x)=>f(x??false), activeColor:NonoTheme.coral, controlAffinity:ListTileControlAffinity.leading, contentPadding:EdgeInsets.zero, title:Text(t, style:const TextStyle(fontWeight:FontWeight.w900, color:NonoTheme.charcoal)));
}
