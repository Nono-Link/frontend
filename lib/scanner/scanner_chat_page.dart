import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../common/models/matching_models.dart';
import '../common/widgets/quick_reply_chat_view.dart';

class ScannerChatPage extends StatelessWidget {
  const ScannerChatPage({super.key});
  @override
  Widget build(BuildContext context) => QuickReplyChatView(
    title: 'scanner_chat_title'.tr(),
    subtitle: 'scanner_chat_subtitle'.tr(),
    viewer: ChatSender.learner,
  );
}
