// 매칭 신청 / 채팅 관련 데이터 모델.
// 실제 API가 붙으면 이 파일의 필드명을 그대로 응답 스키마에 맞춰 쓰면 된다.

enum MatchStatus { pending, accepted, rejected }

enum ChatSender { learner, giver }

/// 재능 나눔이. availablePlaces/Days/TimeSlots는 나눔이가 수기신청서에
/// 등록한(=담당자가 대신 입력한) "가능한" 값만 담는다.
class Giver {
  const Giver({
    required this.id,
    required this.name,
    required this.talentTag,
    required this.nickname,
    required this.avatar,
    required this.availablePlaces,
    required this.availableDays,
    required this.availableTimeSlots,
  });

  final String id, name, talentTag, nickname, avatar;
  final List<String> availablePlaces;
  final List<String> availableDays;
  final List<String> availableTimeSlots; // 예: "14:00~15:00"
}

class MatchRequest {
  const MatchRequest({
    required this.id,
    required this.giverId,
    required this.learnerId,
    required this.place,
    required this.day,
    required this.timeSlot,
    required this.status,
  });

  final String id, giverId, learnerId, place, day, timeSlot;
  final MatchStatus status;

  MatchRequest copyWith({String? place, String? day, String? timeSlot, MatchStatus? status}) => MatchRequest(
    id: id,
    giverId: giverId,
    learnerId: learnerId,
    place: place ?? this.place,
    day: day ?? this.day,
    timeSlot: timeSlot ?? this.timeSlot,
    status: status ?? this.status,
  );
}

class ChatMessage {
  const ChatMessage({
    required this.id,
    required this.sender,
    required this.text,
    required this.sentAt,
    this.isQuickReply = false,
  });

  final String id;
  final ChatSender sender;
  final String text;
  final DateTime sentAt;
  final bool isQuickReply;
}

class ChatRoom {
  ChatRoom({required this.id, required this.matchRequestId, required this.messages, this.isActive = true});

  final String id;
  final String matchRequestId;
  final List<ChatMessage> messages;
  bool isActive;
}
