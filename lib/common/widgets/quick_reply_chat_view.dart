import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../nono_theme.dart';
import '../matching_store.dart';
import '../models/matching_models.dart';
import 'nono_widgets.dart';

/// 나눔이/배움이 화면이 공용으로 쓰는 "버튼 전용" 채팅 뷰.
/// 자유 텍스트 입력창은 없고, 빠른 답장 버튼과 음성 버튼으로만 메시지를 보낸다.
/// [viewer]가 보낸 메시지는 오른쪽(코랄), 상대 메시지는 왼쪽(크림)으로 표시된다.
class QuickReplyChatView extends StatefulWidget {
  const QuickReplyChatView({
    super.key,
    required this.title,
    required this.subtitle,
    required this.viewer,
  });

  final String title, subtitle;
  final ChatSender viewer;

  @override
  State<QuickReplyChatView> createState() => _QuickReplyChatViewState();
}

class _QuickReplyChatViewState extends State<QuickReplyChatView> {
  void _send(String text) {
    setState(() => MatchingStore.instance.sendQuickReply(widget.viewer, text));
  }

  void _speak() {
    // TODO: 실제 STT(음성 인식) 연동. 지금은 버튼 자리와 훅만 마련해둔다.
    nonoToast(context, 'common_chat_voice_toast'.tr());
  }

  @override
  Widget build(BuildContext context) {
    final messages = MatchingStore.instance.chatRoom.messages;
    return NonoPage(children: [
      NonoTop(title: widget.title, subtitle: widget.subtitle),
      const SizedBox(height: 18),
      NonoCard(child: Column(children: [
        for (final m in messages)
          Align(
            alignment: m.sender == widget.viewer ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              constraints: const BoxConstraints(maxWidth: 360),
              decoration: BoxDecoration(
                color: m.sender == widget.viewer ? NonoTheme.coral : NonoTheme.lineSoft,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text(
                m.text,
                style: TextStyle(
                  color: m.sender == widget.viewer ? Colors.white : NonoTheme.charcoal,
                  fontSize: 17,
                  height: 1.4,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
      ])),
      const SizedBox(height: 16),
      Text('common_chat_quick_reply_label'.tr(), style: NonoTheme.h2),
      const SizedBox(height: 10),
      Wrap(
        spacing: 9,
        runSpacing: 9,
        children: quickReplies
            .map((r) => ElevatedButton(
                  onPressed: () => _send(r),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: NonoTheme.paper,
                    foregroundColor: NonoTheme.charcoal,
                    elevation: 0,
                    side: const BorderSide(color: NonoTheme.line, width: 1.5),
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                  ),
                  child: Text(r, style: const TextStyle(fontWeight: FontWeight.w900)),
                ))
            .toList(),
      ),
      const SizedBox(height: 14),
      NonoButton(text: 'common_chat_voice_button'.tr(), icon: Icons.mic, secondary: true, onTap: _speak),
    ]);
  }
}
