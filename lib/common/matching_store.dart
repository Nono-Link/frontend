// 매칭 신청 / 채팅 흐름을 위한 인메모리 mock 저장소.
// common/mock_backend_store.dart(명함 발급용)와 같은 패턴: 실제 백엔드가 없는
// 상태에서 배움이 화면 ↔ 나눔이 화면 사이의 흐름을 시연하기 위한 싱글턴이다.
// 실제 API가 붙으면 아래 각 메서드를 표시된 엔드포인트 호출로 교체하면 된다.

import 'package:easy_localization/easy_localization.dart';
import 'models/matching_models.dart';

/// 빠른 답장 문구 목록. 채팅 화면들에서 공용으로 사용.
List<String> get quickReplies => [
  'common_quick_reply_ok'.tr(),
  'common_quick_reply_meet_at_center'.tr(),
  'common_quick_reply_afternoon'.tr(),
  'common_quick_reply_call_back'.tr(),
];

class MatchingStore {
  MatchingStore._();
  static final instance = MatchingStore._();

  /// 만날 장소/요일/시간대 전체 후보(선택지 UI에서 "비활성"으로 보여줄 대상 포함).
  static List<String> get allPlaces => ['common_place_community_center'.tr(), 'common_place_senior_center'.tr(), 'common_place_cafe'.tr()];
  static List<String> get allDays => ['common_day_mon'.tr(), 'common_day_tue'.tr(), 'common_day_wed'.tr(), 'common_day_thu'.tr(), 'common_day_fri'.tr(), 'common_day_sat'.tr(), 'common_day_sun'.tr()];
  static final List<String> allTimeSlots = List.generate(9, (i) {
    final start = 9 + i;
    return '${_pad(start)}:00~${_pad(start + 1)}:00';
  });
  static String _pad(int h) => h.toString().padLeft(2, '0');

  // 데모용 나눔이(김영자) — 수기신청서에 등록된 값만 활성화됨.
  final Giver demoGiver = Giver(
    id: 'giver-1',
    name: 'common_demo_giver_name'.tr(),
    talentTag: 'common_demo_giver_tag'.tr(),
    nickname: 'common_demo_giver_nickname'.tr(),
    avatar: '🌿',
    availablePlaces: ['common_place_community_center'.tr()],
    availableDays: ['common_day_mon'.tr(), 'common_day_tue'.tr(), 'common_day_thu'.tr()],
    availableTimeSlots: const ['14:00~15:00', '16:00~17:00'],
  );

  MatchRequest? currentRequest;

  /// 거절되어 소진된 (day|timeSlot) 조합. 여러 번 재제안해도 누적 유지.
  final List<String> rejectedSlotKeys = [];

  ChatRoom? _chatRoom;
  ChatRoom get chatRoom => _chatRoom ??= _seedChatRoom();

  ChatRoom _seedChatRoom() => ChatRoom(
    id: 'room-1',
    matchRequestId: currentRequest?.id ?? 'room-1',
    messages: [
      ChatMessage(id: 'm1', sender: ChatSender.learner, text: 'common_chat_seed_message_1'.tr(), sentAt: DateTime.now()),
      ChatMessage(id: 'm2', sender: ChatSender.giver, text: 'common_chat_seed_message_2'.tr(), sentAt: DateTime.now(), isQuickReply: true),
      ChatMessage(id: 'm3', sender: ChatSender.learner, text: 'common_quick_reply_afternoon'.tr(), sentAt: DateTime.now(), isQuickReply: true),
    ],
  );

  bool isSlotRejected(String day, String timeSlot) => rejectedSlotKeys.contains('$day|$timeSlot');

  /// 나눔이가 등록한 요일 × 시간 조합이 전부 거절돼 더 이상 제안할 게 없는지.
  bool get isFullyExhausted {
    for (final d in demoGiver.availableDays) {
      for (final t in demoGiver.availableTimeSlots) {
        if (!isSlotRejected(d, t)) return false;
      }
    }
    return true;
  }

  Future<Giver> fetchGiver(String giverId) async {
    // TODO: connect real API — GET /givers/{giverId}
    await Future.delayed(const Duration(milliseconds: 300));
    return demoGiver;
  }

  Future<MatchRequest> submitMatchRequest({required String place, required String day, required String timeSlot}) async {
    // TODO: connect real API — POST /match-requests
    await Future.delayed(const Duration(milliseconds: 400));
    final req = MatchRequest(
      id: 'req-1',
      giverId: demoGiver.id,
      learnerId: 'learner-1',
      place: place,
      day: day,
      timeSlot: timeSlot,
      status: MatchStatus.pending,
    );
    currentRequest = req;
    return req;
  }

  Future<MatchRequest> resubmitMatchRequest({required String place, required String day, required String timeSlot}) async {
    // TODO: connect real API — POST /match-requests/{id}/resubmit
    await Future.delayed(const Duration(milliseconds: 400));
    final req = currentRequest!.copyWith(place: place, day: day, timeSlot: timeSlot, status: MatchStatus.pending);
    currentRequest = req;
    return req;
  }

  Future<MatchRequest?> fetchMatchRequestStatus() async {
    // TODO: connect real API — GET /match-requests/{id}
    await Future.delayed(const Duration(milliseconds: 200));
    return currentRequest;
  }

  /// 나눔이 쪽 화면(senior_match_page)에서 수락/거절할 때 호출.
  void respondToRequest({required bool accept}) {
    final req = currentRequest;
    if (req == null) return;
    if (accept) {
      currentRequest = req.copyWith(status: MatchStatus.accepted);
    } else {
      rejectedSlotKeys.add('${req.day}|${req.timeSlot}');
      currentRequest = req.copyWith(status: MatchStatus.rejected);
    }
  }

  Future<ChatRoom> fetchChatRoom() async {
    // TODO: connect real API — GET /chat-rooms?matchRequestId=...
    await Future.delayed(const Duration(milliseconds: 200));
    return chatRoom;
  }

  void sendQuickReply(ChatSender sender, String text) {
    // TODO: connect real API — POST /chat-rooms/{id}/messages
    chatRoom.messages.add(ChatMessage(id: 'm${chatRoom.messages.length + 1}', sender: sender, text: text, sentAt: DateTime.now(), isQuickReply: true));
  }
}
