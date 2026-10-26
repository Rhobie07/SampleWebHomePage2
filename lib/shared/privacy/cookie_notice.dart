import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

import 'widgets/privacy_dialog.dart';
import 'widgets/privacy_notice_card.dart';

void showCookieInformation(BuildContext context) {
  showDialog<void>(
    context: context,
    builder: (context) => const PrivacyDialog(),
  );
}

class CookieNotice extends StatefulWidget {
  const CookieNotice({super.key});

  @override
  State<CookieNotice> createState() => _CookieNoticeState();
}

class _CookieNoticeState extends State<CookieNotice> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    try {
      _visible =
          web.window.localStorage.getItem('marci_privacy_acknowledged') !=
          'true';
    } catch (_) {
      _visible = true;
    }
  }

  void _dismiss() {
    try {
      web.window.localStorage.setItem('marci_privacy_acknowledged', 'true');
    } catch (_) {
      // The notice can still be dismissed when browser storage is restricted.
    }
    setState(() => _visible = false);
  }

  @override
  Widget build(BuildContext context) {
    if (!_visible) return const SizedBox.shrink();
    return PrivacyNoticeCard(
      onDismiss: _dismiss,
      onShowDetails: () => showCookieInformation(context),
    );
  }
}
