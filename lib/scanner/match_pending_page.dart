import 'dart:async';
import 'package:flutter/material.dart';
import '../common/nono_theme.dart';
import '../common/widgets/nono_widgets.dart';
import '../common/matching_store.dart';
import '../common/models/matching_models.dart';
import 'match_request_page.dart';
import 'scanner_chat_page.dart';
import 'review_page.dart';

/// 화면 2: 매칭 신청 완료 — 나눔이의 수락을 기다리는 화면.
/// 실제로는 나눔이 쪽에서 수락/거절하는 순간을 감지해야 하므로,
/// my_talent_card_page.dart의 발급 대기 폴링과 같은 패턴으로 상태를 주기적으로 확인한다.
class MatchPendingPage extends StatefulWidget {
  const MatchPendingPage({super.key});

  @override
  State<MatchPendingPage> createState() => _MatchPendingPageState();
}

class _MatchPendingPageState extends State<MatchPendingPage> {
  final _store = MatchingStore.instance;
  Timer? _poll;

  @override
  void initState() {
    super.initState();
    _poll = Timer.periodic(const Duration(seconds: 5), (_) => _checkStatus());
  }

  Future<void> _checkStatus() async {
    final req = await _store.fetchMatchRequestStatus();
    if (!mounted || req == null) return;
    if (req.status == MatchStatus.rejected) {
      _poll?.cancel();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MatchRequestPage(isResubmit: true)));
    } else if (req.status == MatchStatus.accepted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _poll?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final req = _store.currentRequest;
    final g = _store.demoGiver;
    final accepted = req?.status == MatchStatus.accepted;

    return NonoPage(children: [
      const NonoTop(title: '신청 완료', subtitle: '나눔이의 수락을 기다리고 있어요'),
      const SizedBox(height: 18),
      NonoCard(child: Row(children: [
        Text(g.avatar, style: const TextStyle(fontSize: 44)),
        const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('${g.name} 님', style: NonoTheme.h2),
          const SizedBox(height: 4),
          Text('${g.talentTag} · 별명 ${g.nickname}', style: NonoTheme.muted),
        ])),
      ])),
      const SizedBox(height: 16),
      NonoCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('신청한 시간', style: NonoTheme.h2),
        const SizedBox(height: 12),
        _SummaryRow(icon: Icons.place, label: '장소', value: req?.place ?? '-'),
        const SizedBox(height: 8),
        _SummaryRow(icon: Icons.event, label: '요일', value: req?.day ?? '-'),
        const SizedBox(height: 8),
        _SummaryRow(icon: Icons.schedule, label: '시간', value: req?.timeSlot ?? '-'),
      ])),
      const SizedBox(height: 16),
      NonoInfo(
        icon: accepted ? '🎉' : '⏳',
        title: accepted ? '나눔이가 수락했어요!' : '나눔이가 수락하면 채팅으로 연결됩니다',
        body: accepted ? '채팅함에서 만남을 준비해 보세요.' : '조금만 기다려 주세요. 나눔이가 확인 중이에요.',
        color: accepted ? NonoTheme.green : NonoTheme.navy,
      ),
      const SizedBox(height: 18),
      NonoButton(
        text: '채팅함 열기',
        icon: Icons.chat_bubble,
        green: accepted,
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ScannerChatPage())),
      ),
      if (accepted) ...[
        const SizedBox(height: 10),
        NonoButton(
          text: '만남 후 후기 작성하기',
          icon: Icons.rate_review,
          secondary: true,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ReviewPage())),
        ),
      ],
    ]);
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.icon, required this.label, required this.value});
  final IconData icon;
  final String label, value;
  @override
  Widget build(BuildContext context) => Row(children: [
    Icon(icon, size: 20, color: NonoTheme.coral),
    const SizedBox(width: 10),
    Text(label, style: const TextStyle(fontWeight: FontWeight.w900, color: NonoTheme.charcoalSoft)),
    const SizedBox(width: 10),
    Expanded(child: Text(value, style: NonoTheme.body, textAlign: TextAlign.right)),
  ]);
}
