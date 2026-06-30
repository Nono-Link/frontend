import 'package:flutter/material.dart';
import '../nono_theme.dart';

class NonoPage extends StatelessWidget {
  const NonoPage({super.key, required this.children, this.maxWidth = 560});
  final List<Widget> children;
  final double maxWidth;
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: NonoTheme.cream,
    body: SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 34),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: children),
          ),
        ),
      ),
    ),
  );
}

class NonoHeader extends StatelessWidget {
  const NonoHeader({super.key, required this.title, required this.subtitle, this.stamp = true});
  final String title, subtitle;
  final bool stamp;
  @override
  Widget build(BuildContext context) => Column(children: [
    if (stamp) ...[
      Transform.rotate(
        angle: -0.06,
        child: Container(
          width: 62, height: 62, alignment: Alignment.center,
          decoration: BoxDecoration(color: NonoTheme.paper, borderRadius: BorderRadius.circular(16), border: Border.all(color: NonoTheme.red, width: 3), boxShadow: [NonoTheme.shadow]),
          child: const Text('노노\n링크', textAlign: TextAlign.center, style: TextStyle(color: NonoTheme.red, fontWeight: FontWeight.w900, height: 1.05)),
        ),
      ),
      const SizedBox(height: 16),
    ],
    Text(title, textAlign: TextAlign.center, style: NonoTheme.title),
    const SizedBox(height: 8),
    Text(subtitle, textAlign: TextAlign.center, style: NonoTheme.muted),
  ]);
}

class NonoTop extends StatelessWidget {
  const NonoTop({super.key, required this.title, required this.subtitle, this.home = false});
  final String title, subtitle;
  final bool home;
  @override
  Widget build(BuildContext context) => Row(children: [
    IconButton.filledTonal(
      onPressed: () => home ? Navigator.popUntil(context, (r) => r.isFirst) : Navigator.maybePop(context),
      icon: Icon(home ? Icons.home : Icons.arrow_back),
      style: IconButton.styleFrom(backgroundColor: NonoTheme.lineSoft, foregroundColor: NonoTheme.charcoal),
    ),
    const SizedBox(width: 12),
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: NonoTheme.h2),
      const SizedBox(height: 2),
      Text(subtitle, style: NonoTheme.muted),
    ])),
  ]);
}

class NonoCard extends StatelessWidget {
  const NonoCard({super.key, required this.child, this.padding = const EdgeInsets.all(24)});
  final Widget child;
  final EdgeInsets padding;
  @override
  Widget build(BuildContext context) => Container(
    padding: padding,
    decoration: BoxDecoration(color: NonoTheme.paper, borderRadius: BorderRadius.circular(22), border: Border.all(color: NonoTheme.line, width: 1.5), boxShadow: [NonoTheme.shadow]),
    child: child,
  );
}

class NonoButton extends StatelessWidget {
  const NonoButton({super.key, required this.text, required this.onTap, this.icon, this.green = false, this.secondary = false});
  final String text;
  final VoidCallback onTap;
  final IconData? icon;
  final bool green, secondary;
  @override
  Widget build(BuildContext context) {
    if (secondary) {
      return SizedBox(width: double.infinity, height: 54, child: OutlinedButton.icon(
        onPressed: onTap, icon: Icon(icon ?? Icons.arrow_forward), label: Text(text),
        style: OutlinedButton.styleFrom(foregroundColor: NonoTheme.charcoal, side: const BorderSide(color: NonoTheme.line, width: 1.5), textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
      ));
    }
    return SizedBox(width: double.infinity, height: 58, child: ElevatedButton.icon(
      onPressed: onTap, icon: Icon(icon ?? Icons.arrow_forward), label: Text(text),
      style: ElevatedButton.styleFrom(backgroundColor: green ? NonoTheme.green : NonoTheme.coral, foregroundColor: Colors.white, elevation: 0, textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
    ));
  }
}

class NonoInput extends StatelessWidget {
  const NonoInput({super.key, required this.label, required this.controller, required this.hint, this.maxLines = 1, this.keyboardType, this.obscure = false});
  final String label, hint;
  final TextEditingController controller;
  final int maxLines;
  final TextInputType? keyboardType;
  final bool obscure;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontWeight: FontWeight.w900, color: NonoTheme.charcoalSoft)),
      const SizedBox(height: 7),
      TextField(
        controller: controller, keyboardType: keyboardType, obscureText: obscure, maxLines: obscure ? 1 : maxLines,
        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
        decoration: InputDecoration(
          hintText: hint, filled: true, fillColor: NonoTheme.cream,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(13), borderSide: const BorderSide(color: NonoTheme.line, width: 1.5)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(13), borderSide: const BorderSide(color: NonoTheme.coral, width: 2)),
        ),
      ),
    ]),
  );
}

class NonoInfo extends StatelessWidget {
  const NonoInfo({super.key, required this.icon, required this.title, required this.body, this.color = NonoTheme.navy});
  final String icon, title, body;
  final Color color;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(color: color.withOpacity(.07), borderRadius: BorderRadius.circular(16), border: Border.all(color: color.withOpacity(.25), width: 1.4)),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(icon, style: const TextStyle(fontSize: 22)),
      const SizedBox(width: 10),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: TextStyle(color: color, fontWeight: FontWeight.w900, fontSize: 15)),
        const SizedBox(height: 4),
        Text(body, style: TextStyle(color: color, height: 1.45, fontWeight: FontWeight.w600, fontSize: 13)),
      ])),
    ]),
  );
}

class NonoChip extends StatelessWidget {
  const NonoChip({super.key, required this.text, this.color = NonoTheme.coral});
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
    decoration: BoxDecoration(color: color.withOpacity(.10), borderRadius: BorderRadius.circular(99), border: Border.all(color: color.withOpacity(.22))),
    child: Text(text, style: TextStyle(color: color, fontWeight: FontWeight.w900, fontSize: 12)),
  );
}

void nonoToast(BuildContext context, String msg) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
