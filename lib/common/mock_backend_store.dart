// 실제 백엔드가 없는 상태에서 전체 화면 흐름(어르신 발급 대기 ↔ 직원 명함 발급)을
// 시연하기 위한 인메모리 mock 저장소. 실제 API가 붙으면 이 클래스 전체를
// HTTP 호출(GET/POST /cards/status 등)로 교체하면 된다.

class TalentCardData {
  const TalentCardData({required this.code, required this.name, required this.nickname, required this.intro, required this.tags});
  final String code, name, nickname, intro;
  final List<String> tags;
}

class MockBackendStore {
  // 어르신 화면(대기 등록)과 직원 화면(코드 매칭)은 실제로는 서로 다른 기기에서
  // 열리므로, 같은 브라우저 세션을 거치지 않고도 직원 화면을 단독 테스트할 수 있게
  // 데모 코드를 미리 대기 상태로 시드해둔다.
  MockBackendStore._() {
    registerPending('483920');
  }
  static final instance = MockBackendStore._();

  final Set<String> _pendingCodes = {};
  final Map<String, TalentCardData> _issuedCards = {};

  void registerPending(String code) => _pendingCodes.add(code);

  bool matchesPending(String code) => _pendingCodes.contains(code);

  void issue(String code, TalentCardData data) {
    _pendingCodes.remove(code);
    _issuedCards[code] = data;
  }

  TalentCardData? issuedCardFor(String code) => _issuedCards[code];
}
