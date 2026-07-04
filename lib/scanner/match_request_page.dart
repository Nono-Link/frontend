import 'package:flutter/material.dart';
import '../common/nono_theme.dart';
import '../common/widgets/nono_widgets.dart';
import '../common/matching_store.dart';
import '../common/models/matching_models.dart';
import 'match_pending_page.dart';

/// 화면 1(매칭 신청) & 화면 3(거절 후 재제안)을 겸하는 화면.
/// [isResubmit]이 true면 직전에 거절된 시간을 배너로 보여주고, 이미 거절돼
/// 소진된 요일·시간 조합은 계속 잠긴 채로 유지된다(MatchingStore에 누적).
class MatchRequestPage extends StatefulWidget {
  const MatchRequestPage({super.key, this.isResubmit = false});
  final bool isResubmit;

  @override
  State<MatchRequestPage> createState() => _MatchRequestPageState();
}

class _MatchRequestPageState extends State<MatchRequestPage> {
  final _store = MatchingStore.instance;
  Giver? giver;
  String? selectedPlace;
  String? selectedDay;
  String? selectedTimeSlot;
  bool submitting = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final g = await _store.fetchGiver(_store.demoGiver.id);
    if (!mounted) return;
    setState(() {
      giver = g;
      if (g.availablePlaces.length == 1) selectedPlace = g.availablePlaces.first;
    });
  }

  bool get _canSubmit => selectedPlace != null && selectedDay != null && selectedTimeSlot != null;

  Future<void> _submit() async {
    if (!_canSubmit || submitting) return;
    setState(() => submitting = true);
    widget.isResubmit
        ? await _store.resubmitMatchRequest(place: selectedPlace!, day: selectedDay!, timeSlot: selectedTimeSlot!)
        : await _store.submitMatchRequest(place: selectedPlace!, day: selectedDay!, timeSlot: selectedTimeSlot!);
    if (!mounted) return;
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MatchPendingPage()));
  }

  @override
  Widget build(BuildContext context) {
    final g = giver;
    if (g == null) {
      return const NonoPage(children: [SizedBox(height: 120, child: Center(child: CircularProgressIndicator()))]);
    }

    final exhausted = _store.isFullyExhausted;
    final rejected = widget.isResubmit ? _store.currentRequest : null;

    return NonoPage(children: [
      NonoTop(title: widget.isResubmit ? '다른 시간 다시 선택' : '매칭 신청', subtitle: '나눔이가 등록한 시간 중에서만 고를 수 있어요'),
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
      if (rejected != null)
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: NonoInfo(
            icon: '😥',
            title: '${g.name} 님이 이 시간은 어렵다고 하셨어요',
            body: '거절된 시간: ${rejected.day} ${rejected.timeSlot} · ${rejected.place}\n아래에서 다른 시간을 다시 골라주세요.',
            color: NonoTheme.red,
          ),
        ),
      if (exhausted)
        const NonoInfo(icon: '🙏', title: '가능한 시간이 더 없어요', body: '나눔이가 등록한 시간을 모두 제안했어요. 담당자에게 문의해 주세요.', color: NonoTheme.red)
      else ...[
        _Section(
          title: '만날 장소',
          child: Wrap(spacing: 8, runSpacing: 8, children: [
            for (final p in MatchingStore.allPlaces)
              _SelectableChip(
                label: p,
                selected: selectedPlace == p,
                enabled: g.availablePlaces.contains(p),
                badge: g.availablePlaces.contains(p) ? '나눔이 지정' : null,
                onTap: () => setState(() => selectedPlace = p),
              ),
          ]),
        ),
        const SizedBox(height: 18),
        _Section(
          title: '가능한 요일',
          child: Wrap(spacing: 8, runSpacing: 8, children: [
            for (final d in MatchingStore.allDays)
              _SelectableChip(
                label: d,
                selected: selectedDay == d,
                enabled: g.availableDays.contains(d),
                onTap: () => setState(() {
                  selectedDay = d;
                  if (selectedTimeSlot != null && _store.isSlotRejected(d, selectedTimeSlot!)) {
                    selectedTimeSlot = null;
                  }
                }),
              ),
          ]),
        ),
        const SizedBox(height: 18),
        _Section(
          title: '가능한 시간대',
          child: selectedDay == null
              ? const Text('요일을 먼저 선택해 주세요', style: NonoTheme.muted)
              : Wrap(spacing: 8, runSpacing: 8, children: [
                  for (final t in MatchingStore.allTimeSlots)
                    _SelectableChip(
                      label: t,
                      selected: selectedTimeSlot == t,
                      enabled: g.availableTimeSlots.contains(t) && !_store.isSlotRejected(selectedDay!, t),
                      onTap: () => setState(() => selectedTimeSlot = t),
                    ),
                ]),
        ),
        const SizedBox(height: 10),
        const Text('회색으로 잠긴 항목은 나눔이가 등록하지 않았거나 이미 거절한 시간이라 고를 수 없어요.', style: NonoTheme.muted),
        const SizedBox(height: 18),
        NonoCard(
          padding: const EdgeInsets.all(18),
          child: Row(children: [
            const Icon(Icons.event_available, color: NonoTheme.coral),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                [selectedPlace, selectedDay, selectedTimeSlot].every((e) => e == null)
                    ? '장소 · 요일 · 시간을 선택해 주세요'
                    : '${selectedPlace ?? '장소 미선택'} · ${selectedDay ?? '요일 미선택'} · ${selectedTimeSlot ?? '시간 미선택'}',
                style: NonoTheme.body,
              ),
            ),
          ]),
        ),
        const SizedBox(height: 18),
        NonoButton(
          text: submitting ? '신청 중...' : (widget.isResubmit ? '다른 시간으로 다시 신청하기' : '이 시간으로 신청하기'),
          icon: Icons.send,
          onTap: _canSubmit && !submitting ? _submit : () => nonoToast(context, '장소 · 요일 · 시간을 모두 선택해 주세요.'),
        ),
      ],
    ]);
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});
  final String title;
  final Widget child;
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(title, style: NonoTheme.h2),
    const SizedBox(height: 10),
    child,
  ]);
}

class _SelectableChip extends StatelessWidget {
  const _SelectableChip({required this.label, required this.selected, required this.enabled, required this.onTap, this.badge});
  final String label;
  final bool selected, enabled;
  final VoidCallback onTap;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    final color = !enabled ? NonoTheme.charcoalSoft : (selected ? Colors.white : NonoTheme.charcoal);
    final bg = !enabled ? NonoTheme.lineSoft.withValues(alpha: .6) : (selected ? NonoTheme.coral : NonoTheme.paper);
    final border = !enabled ? NonoTheme.line : (selected ? NonoTheme.coral : NonoTheme.line);

    return Opacity(
      opacity: enabled ? 1 : .55,
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(14), border: Border.all(color: border, width: 1.5)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Row(mainAxisSize: MainAxisSize.min, children: [
              if (!enabled) const Padding(padding: EdgeInsets.only(right: 5), child: Icon(Icons.lock, size: 14, color: NonoTheme.charcoalSoft)),
              Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w900, fontSize: 15)),
            ]),
            if (badge != null)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(badge!, style: TextStyle(color: selected ? Colors.white70 : NonoTheme.green, fontWeight: FontWeight.w800, fontSize: 10)),
              ),
          ]),
        ),
      ),
    );
  }
}
