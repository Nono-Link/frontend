import 'dart:async';
import 'package:flutter/material.dart';
import '../common/nono_theme.dart';
import '../common/widgets/nono_widgets.dart';
import '../common/mock_backend_store.dart';
import 'senior_match_page.dart';
import 'senior_chat_page.dart';

enum IssuanceStatus { pending, issued }

const _demoCode = '483920';
const _previewDemoCard = TalentCardData(code: _demoCode, name: '김영자', nickname: '나눔이', intro: '작은 화분을 오래 건강하게 키우는 법을 알려드려요.', tags: ['원예', '평일 오후', '주민센터']);

/// 발급 상태 조회를 UI에서 분리한 저장소. 실제 연동 시 GET /cards/status?code=... 호출로 교체.
class TalentCardRepository {
  const TalentCardRepository();
  Future<TalentCardData?> fetchIssuedCard(String code) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return MockBackendStore.instance.issuedCardFor(code);
  }
}

class _TalentColors {
  static const dark = Color(0xFF3B404B);
  static const digitBox = Color(0xFF4B515E);
  static const mutedOnDark = Color(0xFFB9BEC9);
  static const dashedBorder = Color(0xFFC9C0AB);
  static const success = Color(0xFF4E7C4E);
  static const brown = Color(0xFF9A6B3B);
  static const salmon = Color(0xFFF5D5C8);
  static const salmonText = Color(0xFFC05B3B);
}

class MyTalentCardScreen extends StatefulWidget {
  const MyTalentCardScreen({super.key, this.code = _demoCode, this.repository});
  final String code;
  final TalentCardRepository? repository;
  @override
  State<MyTalentCardScreen> createState() => _MyTalentCardScreenState();
}

class _MyTalentCardScreenState extends State<MyTalentCardScreen> {
  late final TalentCardRepository _repo = widget.repository ?? const TalentCardRepository();
  IssuanceStatus status = IssuanceStatus.pending;
  TalentCardData? issuedCard;
  Timer? _poll;

  @override
  void initState() {
    super.initState();
    MockBackendStore.instance.registerPending(widget.code);
    _startPolling();
  }

  void _startPolling() {
    _poll?.cancel();
    _poll = Timer.periodic(const Duration(seconds: 5), (_) => _checkStatus());
  }

  Future<void> _checkStatus({bool manual = false}) async {
    final card = await _repo.fetchIssuedCard(widget.code);
    if (!mounted) return;
    if (card != null) {
      _poll?.cancel();
      setState(() {
        status = IssuanceStatus.issued;
        issuedCard = card;
      });
    } else if (manual) {
      nonoToast(context, '아직 발급 대기중이에요');
    }
  }

  // 프리뷰용 임시 토글: 로컬 상태만 바꿀 뿐 MockBackendStore는 건드리지 않아
  // 실제 발급 흐름(직원 화면 → 폴링 감지)과 충돌 없이 UI만 빠르게 확인할 수 있다.
  void _togglePreview() {
    setState(() {
      if (status == IssuanceStatus.pending) {
        status = IssuanceStatus.issued;
        issuedCard ??= _previewDemoCard;
      } else {
        status = IssuanceStatus.pending;
      }
    });
    status == IssuanceStatus.issued ? _poll?.cancel() : _startPolling();
  }

  @override
  void dispose() {
    _poll?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final issued = status == IssuanceStatus.issued && issuedCard != null;
    return Scaffold(
      backgroundColor: NonoTheme.cream,
      floatingActionButton: FloatingActionButton.small(
        heroTag: 'talent-card-preview-toggle',
        backgroundColor: NonoTheme.charcoalSoft,
        onPressed: _togglePreview,
        tooltip: '미리보기 상태 전환 (임시)',
        child: const Icon(Icons.swap_horiz, color: Colors.white),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 34),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                _Header(issued: issued),
                const SizedBox(height: 20),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  transitionBuilder: (child, anim) => FadeTransition(
                    opacity: anim,
                    child: SlideTransition(position: Tween<Offset>(begin: const Offset(0, .04), end: Offset.zero).animate(anim), child: child),
                  ),
                  child: issued
                      ? _IssuedContent(key: const ValueKey('issued'), data: issuedCard!)
                      : _PendingContent(key: const ValueKey('pending'), code: widget.code),
                ),
                const SizedBox(height: 20),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: issued
                      ? const _IssuedActions(key: ValueKey('issued-actions'))
                      : _PendingAction(key: const ValueKey('pending-action'), onTap: () => _checkStatus(manual: true)),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.issued});
  final bool issued;
  @override
  Widget build(BuildContext context) => Row(children: [
    IconButton.filledTonal(
      onPressed: () => Navigator.maybePop(context),
      icon: const Icon(Icons.arrow_back),
      style: IconButton.styleFrom(backgroundColor: NonoTheme.lineSoft, foregroundColor: NonoTheme.charcoal, minimumSize: const Size(48, 48)),
    ),
    const SizedBox(width: 12),
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('내 재능 명함', style: NonoTheme.h2),
      const SizedBox(height: 2),
      Text(
        issued ? '명함이 발급되었어요 🎉' : '담당자에게 코드를 보여주세요',
        style: issued ? const TextStyle(color: _TalentColors.success, fontWeight: FontWeight.w800, fontSize: 14) : NonoTheme.muted,
      ),
    ])),
  ]);
}

class _PendingContent extends StatelessWidget {
  const _PendingContent({super.key, required this.code});
  final String code;
  @override
  Widget build(BuildContext context) {
    final digits = code.split('');
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(color: _TalentColors.dark, borderRadius: BorderRadius.circular(20)),
        child: Column(children: [
          const Text('구청 직원에게 보여줄 식별코드', textAlign: TextAlign.center, style: TextStyle(color: _TalentColors.mutedOnDark, fontWeight: FontWeight.w700, fontSize: 14)),
          const SizedBox(height: 18),
          Wrap(alignment: WrapAlignment.center, spacing: 8, runSpacing: 8, children: [
            for (final d in digits)
              Container(
                width: 44, height: 56, alignment: Alignment.center,
                decoration: BoxDecoration(color: _TalentColors.digitBox, borderRadius: BorderRadius.circular(12)),
                child: Text(d, style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w900)),
              ),
          ]),
          const SizedBox(height: 16),
          const Text('이 코드로 담당자가 명함을 발급해요', textAlign: TextAlign.center, style: TextStyle(color: _TalentColors.mutedOnDark, fontWeight: FontWeight.w600, fontSize: 13)),
        ]),
      ),
      const SizedBox(height: 16),
      CustomPaint(
        painter: const _DashedRRectPainter(radius: 20, color: _TalentColors.dashedBorder),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 20),
          decoration: BoxDecoration(color: NonoTheme.lineSoft.withValues(alpha: .4), borderRadius: BorderRadius.circular(20)),
          child: Column(children: [
            const Icon(Icons.badge_outlined, size: 46, color: NonoTheme.charcoalSoft),
            const SizedBox(height: 14),
            const Text('아직 발급된 명함이 없어요', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w900, color: NonoTheme.charcoal)),
            const SizedBox(height: 8),
            const Text('구청 직원이 코드를 확인하면\n명함이 만들어져요', textAlign: TextAlign.center, style: NonoTheme.muted),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(color: NonoTheme.lineSoft, borderRadius: BorderRadius.circular(99)),
              child: const Text('⏳ 발급 대기중', style: TextStyle(fontWeight: FontWeight.w800, color: NonoTheme.charcoalSoft)),
            ),
          ]),
        ),
      ),
    ]);
  }
}

class _IssuedContent extends StatelessWidget {
  const _IssuedContent({super.key, required this.data});
  final TalentCardData data;
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(color: NonoTheme.lineSoft, borderRadius: BorderRadius.circular(99)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('식별코드 ${data.code}', style: NonoTheme.muted),
        const Text('사용 완료 ✓', style: TextStyle(color: _TalentColors.success, fontWeight: FontWeight.w800)),
      ]),
    ),
    const SizedBox(height: 16),
    NonoCard(child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        width: 56, height: 56, alignment: Alignment.center,
        decoration: BoxDecoration(color: NonoTheme.green.withValues(alpha: .12), borderRadius: BorderRadius.circular(16)),
        child: const Text('🌿', style: TextStyle(fontSize: 26)),
      ),
      const SizedBox(width: 14),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('${data.name} 님', style: NonoTheme.h2),
        const SizedBox(height: 2),
        Text('별명 · ${data.nickname}', style: const TextStyle(color: _TalentColors.brown, fontWeight: FontWeight.w800, fontSize: 14)),
        const SizedBox(height: 10),
        Text(data.intro, style: NonoTheme.body),
        const SizedBox(height: 12),
        Wrap(spacing: 8, runSpacing: 8, children: [
          for (final t in data.tags)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(color: _TalentColors.salmon, borderRadius: BorderRadius.circular(99)),
              child: Text(t, style: const TextStyle(color: _TalentColors.salmonText, fontWeight: FontWeight.w900, fontSize: 12)),
            ),
        ]),
      ])),
    ])),
  ]);
}

class _PendingAction extends StatelessWidget {
  const _PendingAction({super.key, required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => NonoButton(text: '내 명함 보러 가기', icon: Icons.badge, secondary: true, onTap: onTap);
}

class _IssuedActions extends StatelessWidget {
  const _IssuedActions({super.key});
  @override
  Widget build(BuildContext context) => Column(children: [
    NonoButton(text: '새 매칭 요청 확인', icon: Icons.favorite, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SeniorMatchPage()))),
    const SizedBox(height: 12),
    NonoButton(text: '채팅함 열기', icon: Icons.chat_bubble, secondary: true, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SeniorChatPage()))),
  ]);
}

class _DashedRRectPainter extends CustomPainter {
  const _DashedRRectPainter({required this.radius, required this.color});
  static const _strokeWidth = 1.6, _dashWidth = 6.0, _gapWidth = 5.0;
  final double radius;
  final Color color;
  @override
  void paint(Canvas canvas, Size size) {
    final rrect = RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(radius));
    final path = Path()..addRRect(rrect);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = _strokeWidth;
    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        final next = distance + _dashWidth;
        canvas.drawPath(metric.extractPath(distance, next.clamp(0, metric.length)), paint);
        distance = next + _gapWidth;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedRRectPainter oldDelegate) => oldDelegate.color != color || oldDelegate.radius != radius;
}
