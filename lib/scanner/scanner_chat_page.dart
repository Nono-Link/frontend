import 'package:flutter/material.dart';
import '../common/models/matching_models.dart';
import '../common/widgets/quick_reply_chat_view.dart';

class ScannerChatPage extends StatelessWidget {
  const ScannerChatPage({super.key});
  @override
  Widget build(BuildContext context) => const QuickReplyChatView(
    title: '채팅함',
    subtitle: '자주 쓰는 답장을 눌러 편하게 대화합니다',
    viewer: ChatSender.learner,
  );
}
