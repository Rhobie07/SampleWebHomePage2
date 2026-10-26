import 'package:flutter/material.dart';

import 'widgets/privacy_dialog.dart';

void showCookieInformation(BuildContext context) {
  showDialog<void>(
    context: context,
    builder: (context) => const PrivacyDialog(),
  );
}
