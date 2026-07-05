import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../common/models/matching_models.dart';
import '../common/widgets/quick_reply_chat_view.dart';

class SeniorChatPage extends StatelessWidget {
  const SeniorChatPage({super.key});
  @override
  Widget build(BuildContext context) => QuickReplyChatView(
    title: 'senior_chat_title'.tr(),
    subtitle: 'senior_chat_subtitle'.tr(),
    viewer: ChatSender.giver,
  );
}
