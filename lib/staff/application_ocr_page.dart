import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../common/nono_theme.dart';
import '../common/widgets/nono_widgets.dart';
import 'application_review_page.dart';

class ApplicationOcrPage extends StatefulWidget { const ApplicationOcrPage({super.key}); @override State<ApplicationOcrPage> createState() => _ApplicationOcrPageState(); }
class _ApplicationOcrPageState extends State<ApplicationOcrPage> { bool scanned = false;
  @override Widget build(BuildContext context) => NonoPage(children: [
    NonoTop(title: 'staff_step_ocr_title'.tr(), subtitle: 'staff_ocr_subtitle'.tr()),
    const SizedBox(height: 18),
    NonoCard(child: Column(children: [
      Container(height: 300, width: double.infinity, padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: NonoTheme.cream, borderRadius: BorderRadius.circular(20), border: Border.all(color: scanned ? NonoTheme.green : NonoTheme.line, width: 2)), child: scanned ? _done() : _camera()),
      const SizedBox(height: 18),
      NonoButton(text: scanned ? 'staff_ocr_view_result_button'.tr() : 'staff_ocr_capture_button'.tr(), icon: scanned ? Icons.fact_check : Icons.camera_alt, green: scanned, onTap: () { if (scanned) { Navigator.push(context, MaterialPageRoute(builder: (_) => const ApplicationReviewPage())); } else { setState(() => scanned = true); nonoToast(context, 'staff_ocr_toast_scan_done'.tr()); }}),
      const SizedBox(height: 10),
      NonoButton(text: 'staff_ocr_upload_button'.tr(), icon: Icons.upload_file, secondary: true, onTap: () { setState(() => scanned = true); nonoToast(context, 'staff_ocr_toast_upload_done'.tr()); }),
    ])),
    const SizedBox(height: 14),
    NonoInfo(icon: '🩵', title: 'staff_ocr_info_title'.tr(), body: 'staff_ocr_info_body'.tr()),
  ]);
  Widget _camera() => Column(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.document_scanner, size: 80, color: NonoTheme.charcoalSoft), const SizedBox(height: 14), Text('staff_ocr_camera_guide'.tr(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900)), const SizedBox(height: 6), Text('staff_ocr_camera_hint'.tr(), textAlign: TextAlign.center, style: NonoTheme.muted)]);
  Widget _done() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [const Icon(Icons.check_circle, color: NonoTheme.green), const SizedBox(width: 8), Text('staff_ocr_done_title'.tr(), style: const TextStyle(color: NonoTheme.green, fontSize: 20, fontWeight: FontWeight.w900))]), const SizedBox(height: 18), Text('staff_ocr_result_name'.tr(), style: NonoTheme.body), Text('staff_ocr_result_talent'.tr(), style: NonoTheme.body), Text('staff_ocr_result_career'.tr(), style: NonoTheme.body), Text('staff_ocr_result_activity'.tr(), style: NonoTheme.body), const Spacer(), Text('staff_ocr_result_footer'.tr(), style: NonoTheme.muted)]);
}
