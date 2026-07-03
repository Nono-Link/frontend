import 'package:flutter/material.dart';
import '../common/nono_theme.dart';
import '../common/widgets/nono_widgets.dart';
import '../common/mock_backend_store.dart';
import 'card_preview_page.dart';

class ApplicationReviewPage extends StatefulWidget {
  const ApplicationReviewPage({super.key});
  @override
  State<ApplicationReviewPage> createState() => _ApplicationReviewPageState();
}

class _ApplicationReviewPageState extends State<ApplicationReviewPage> {
  final name = TextEditingController(text: '김영자'),
      nickname = TextEditingController(text: '나눔이'),
      age = TextEditingController(text: '70대'),
      town = TextEditingController(text: '성북동'),
      phone = TextEditingController(text: '010-1234-5678'),
      talent = TextEditingController(text: '원예, 화분 가꾸기'),
      career = TextEditingController(text: '20년'),
      intro = TextEditingController(text: '작은 화분을 오래 건강하게 키우는 법을 알려드립니다.'),
      pref = TextEditingController(text: '평일 오후 · 주민센터 · 1:1'),
      mood = TextEditingController(text: '따뜻한'),
      identCode = TextEditingController(text: '483920');
  @override
  Widget build(BuildContext context) => NonoPage(
    children: [
      const NonoTop(title: '신청서 내용 확인', subtitle: '명함에 반영될 정보와 안전 동의를 확인합니다'),
      const SizedBox(height: 16),
      const NonoInfo(
        icon: '🔎',
        title: '확인 필요',
        body: '명함 발급 전 담당자가 신청서 내용과 동의 항목을 최종 확인합니다.',
        color: NonoTheme.coral,
      ),
      const SizedBox(height: 16),
      NonoCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('기본·재능 정보', style: NonoTheme.h2),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(child: NonoInput(label: '성함', controller: name, hint: '성함')),
                const SizedBox(width: 12),
                Expanded(child: NonoInput(label: '별명', controller: nickname, hint: '나눔이')),
              ],
            ),
            NonoInput(label: '연령대', controller: age, hint: '70대'),
            NonoInput(label: '동네', controller: town, hint: '성북동'),
            NonoInput(label: '연락처', controller: phone, hint: '010-1234-5678'),
            NonoInput(label: '재능', controller: talent, hint: '원예'),
            NonoInput(label: '경력', controller: career, hint: '20년'),
            NonoInput(
              label: '한 줄 소개',
              controller: intro,
              hint: '저는 ... 를 잘합니다.',
              maxLines: 3,
            ),
            NonoInput(
              label: '활동 선호',
              controller: pref,
              hint: '평일 오후 · 주민센터',
              maxLines: 2,
            ),
            NonoInput(label: '명함 분위기', controller: mood, hint: '따뜻한'),
          ],
        ),
      ),
      const SizedBox(height: 16),
      NonoCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('식별코드 확인', style: NonoTheme.h2),
            const SizedBox(height: 4),
            const Text('어르신 앱 화면에 표시된 6자리 코드를 입력해 대조합니다.', style: NonoTheme.muted),
            const SizedBox(height: 14),
            NonoInput(label: '식별코드', controller: identCode, hint: '483920', keyboardType: TextInputType.number),
            const SizedBox(height: 8),
            NonoButton(
              text: '확인 완료하고 명함 발급',
              icon: Icons.badge,
              onTap: () {
                final code = identCode.text.trim();
                if (!MockBackendStore.instance.matchesPending(code)) {
                  nonoToast(context, '식별코드가 일치하지 않습니다. 다시 확인해 주세요.');
                  return;
                }
                MockBackendStore.instance.issue(code, TalentCardData(
                  code: code,
                  name: name.text.trim(),
                  nickname: nickname.text.trim(),
                  intro: intro.text.trim(),
                  tags: [
                    talent.text.split(',').first.trim(),
                    ...pref.text.split('·').take(2).map((e) => e.trim()),
                  ],
                ));
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CardPreviewPage()),
                );
              },
            ),
          ],
        ),
      ),
    ],
  );
}
