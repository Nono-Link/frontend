import 'package:flutter/material.dart';

class LoginExpertPage extends StatefulWidget {
  const LoginExpertPage({super.key});

  @override
  State<LoginExpertPage> createState() => _LoginExpertPageState();
}

class _LoginExpertPageState extends State<LoginExpertPage> {
  bool isLogin = true;
  bool isSignupDone = false;
  String role = 'STAFF';

  final loginIdController = TextEditingController();
  final loginPwController = TextEditingController();

  final signupIdController = TextEditingController();
  final signupPwController = TextEditingController();
  final nameController = TextEditingController();
  final birthController = TextEditingController();
  final phoneController = TextEditingController();

  bool idError = false;
  bool pwError = false;
  bool nameError = false;
  bool birthError = false;
  bool phoneError = false;

  static const cream = Color(0xFFFFF9F1);
  static const paper = Color(0xFFFFFDF9);
  static const charcoal = Color(0xFF1E293B);
  static const charcoalSoft = Color(0xFF475569);
  static const coral = Color(0xFFFF6B4A);
  static const coralDark = Color(0xFFE2543A);
  static const red = Color(0xFFE63946);
  static const navy = Color(0xFF2A4365);
  static const line = Color(0xFFEADFCF);
  static const lineSoft = Color(0xFFF2E8D8);

  void changeTab(bool login) {
    setState(() {
      isLogin = login;
      isSignupDone = false;
    });
  }

  void signup() {
    final id = signupIdController.text.trim();
    final pw = signupPwController.text;
    final name = nameController.text.trim();
    final birth = birthController.text.trim();
    final phone = phoneController.text.trim();

    setState(() {
      idError = id.length < 4;
      pwError = pw.length < 8;
      nameError = name.isEmpty;
      birthError = !RegExp(r'^\d{4}$').hasMatch(birth);
      phoneError = phone.isEmpty;
    });

    final hasError = idError || pwError || nameError || birthError || phoneError;

    if (hasError) return;

    setState(() {
      isSignupDone = true;
    });
  }

  void login() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('로그인 → 어르신 등록 시스템으로 이동합니다. (목업 단계)'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Column(
                children: [
                  _brandHeader(),
                  const SizedBox(height: 26),
                  _tabs(),
                  const SizedBox(height: 22),
                  _card(
                    child: isLogin ? _loginPane() : _signupPane(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _brandHeader() {
    return Column(
      children: [
        Transform.rotate(
          angle: -0.07,
          child: Container(
            width: 60,
            height: 60,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: paper,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: red, width: 3),
            ),
            child: const Text(
              '노노\n링크',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: red,
                fontWeight: FontWeight.w800,
                height: 1.05,
              ),
            ),
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          '직원·봉사자 계정',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: charcoal,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          '어르신을 대신 등록하는 담당자용 로그인입니다',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: charcoalSoft,
          ),
        ),
      ],
    );
  }

  Widget _tabs() {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: lineSoft,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          _tabButton('로그인', isLogin, () => changeTab(true)),
          const SizedBox(width: 8),
          _tabButton('회원가입', !isLogin, () => changeTab(false)),
        ],
      ),
    );
  }

  Widget _tabButton(String text, bool active, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: active ? paper : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: active
                ? [
                    BoxShadow(
                      color: Colors.brown.withOpacity(0.12),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [],
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: active ? charcoal : charcoalSoft,
            ),
          ),
        ),
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: paper,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: line, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.brown.withOpacity(0.12),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _loginPane() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title('다시 오셨네요'),
        _lead('발급받은 아이디로 로그인하세요.'),
        _field(
          label: '아이디',
          controller: loginIdController,
          hint: '예: gangbuk_volunteer',
        ),
        _field(
          label: '비밀번호',
          controller: loginPwController,
          hint: '비밀번호 입력',
          obscureText: true,
        ),
        _mainButton('로그인', login),
        _switchText(
          '계정이 없으신가요?',
          '회원가입',
          () => changeTab(false),
        ),
      ],
    );
  }

  Widget _signupPane() {
    if (isSignupDone) {
      final name = nameController.text.trim();
      final label = role == 'STAFF' ? '지자체 직원' : '자원봉사자';

      return Column(
        children: [
          const Text('🎉', style: TextStyle(fontSize: 48)),
          const SizedBox(height: 8),
          const Text(
            '가입이 완료됐어요',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w800,
              color: charcoal,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '$name 님 ($label) 계정이 만들어졌어요. 로그인해서 어르신 등록을 시작하세요.',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15, color: charcoalSoft),
          ),
          const SizedBox(height: 20),
          _mainButton('로그인하러 가기', () => changeTab(true)),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title('담당자 계정 만들기'),
        _lead('소속과 역할을 선택한 뒤 정보를 입력하세요.'),
        _roleSelector(),
        _field(
          label: '아이디',
          controller: signupIdController,
          hint: '영문·숫자 4자 이상',
          error: idError ? '아이디를 4자 이상 입력해 주세요.' : null,
        ),
        _field(
          label: '비밀번호',
          controller: signupPwController,
          hint: '8자 이상',
          obscureText: true,
          helper: '서버에서 bcrypt로 안전하게 암호화되어 저장됩니다.',
          error: pwError ? '비밀번호를 8자 이상 입력해 주세요.' : null,
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            final isSmall = constraints.maxWidth < 420;

            if (isSmall) {
              return Column(
                children: [
                  _field(
                    label: '이름',
                    controller: nameController,
                    hint: '홍길동',
                    error: nameError ? '이름을 입력해 주세요.' : null,
                  ),
                  _field(
                    label: '출생연도',
                    controller: birthController,
                    hint: '1990',
                    keyboardType: TextInputType.number,
                    error: birthError ? '4자리 연도를 입력해 주세요.' : null,
                  ),
                ],
              );
            }

            return Row(
              children: [
                Expanded(
                  child: _field(
                    label: '이름',
                    controller: nameController,
                    hint: '홍길동',
                    error: nameError ? '이름을 입력해 주세요.' : null,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _field(
                    label: '출생연도',
                    controller: birthController,
                    hint: '1990',
                    keyboardType: TextInputType.number,
                    error: birthError ? '4자리 연도를 입력해 주세요.' : null,
                  ),
                ),
              ],
            );
          },
        ),
        _field(
          label: '전화번호',
          controller: phoneController,
          hint: '010-1234-5678',
          keyboardType: TextInputType.phone,
          error: phoneError ? '전화번호를 입력해 주세요.' : null,
        ),
        _mainButton('회원가입 완료', signup),
        const SizedBox(height: 18),
        _notice(),
        _switchText(
          '이미 계정이 있으신가요?',
          '로그인',
          () => changeTab(true),
        ),
      ],
    );
  }

  Widget _roleSelector() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmall = constraints.maxWidth < 420;

        final children = [
          Expanded(
            child: _roleCard(
              emoji: '🏛️',
              title: '지자체 직원',
              subtitle: 'STAFF',
              value: 'STAFF',
            ),
          ),
          SizedBox(width: isSmall ? 0 : 12, height: isSmall ? 12 : 0),
          Expanded(
            child: _roleCard(
              emoji: '🤝',
              title: '자원봉사자',
              subtitle: 'VOLUNTEER',
              value: 'VOLUNTEER',
            ),
          ),
        ];

        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: isSmall
              ? Column(children: children)
              : Row(children: children),
        );
      },
    );
  }

  Widget _roleCard({
    required String emoji,
    required String title,
    required String subtitle,
    required String value,
  }) {
    final selected = role == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          role = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        decoration: BoxDecoration(
          color: selected ? coral.withOpacity(0.06) : cream,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? coral : line,
            width: 2,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: Colors.brown.withOpacity(0.12),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  )
                ]
              : [],
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 28)),
            const SizedBox(height: 6),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: charcoal,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 12,
                color: charcoalSoft,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field({
    required String label,
    required TextEditingController controller,
    required String hint,
    bool obscureText = false,
    TextInputType? keyboardType,
    String? helper,
    String? error,
  }) {
    final hasError = error != null;

    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: charcoalSoft,
              ),
              children: const [
                TextSpan(
                  text: ' *',
                  style: TextStyle(color: coral),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: cream,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 13,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11),
                borderSide: BorderSide(
                  color: hasError ? red : line,
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11),
                borderSide: BorderSide(
                  color: hasError ? red : coral,
                  width: 1.5,
                ),
              ),
            ),
          ),
          if (helper != null) ...[
            const SizedBox(height: 5),
            Text(
              helper,
              style: const TextStyle(fontSize: 12, color: charcoalSoft),
            ),
          ],
          if (error != null) ...[
            const SizedBox(height: 5),
            Text(
              error,
              style: const TextStyle(
                fontSize: 12,
                color: red,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _mainButton(String text, VoidCallback onTap) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 6),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: coral,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }

  Widget _switchText(String normal, String link, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: Center(
        child: GestureDetector(
          onTap: onTap,
          child: RichText(
            text: TextSpan(
              text: '$normal ',
              style: const TextStyle(
                fontSize: 14,
                color: charcoalSoft,
              ),
              children: [
                TextSpan(
                  text: link,
                  style: const TextStyle(
                    color: coral,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _notice() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: navy.withOpacity(0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: navy.withOpacity(0.25),
          width: 1.5,
        ),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('👵'),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              '어르신은 이 화면으로 가입하지 않습니다. 어르신 계정은 직원·봉사자가 신청서를 받아 대신 등록합니다. 이 가입은 그 등록을 수행할 담당자 전용입니다.',
              style: TextStyle(
                fontSize: 13,
                color: navy,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _title(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w800,
        color: charcoal,
      ),
    );
  }

  Widget _lead(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 22),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15,
          color: charcoalSoft,
        ),
      ),
    );
  }
}