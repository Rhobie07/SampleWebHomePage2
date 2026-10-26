import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openSiteUrl(BuildContext context, Uri uri) async {
  try {
    final opened = await launchUrl(
      uri,
      webOnlyWindowName: uri.scheme == 'https' ? '_blank' : '_self',
    );
    if (opened || !context.mounted) return;
  } catch (_) {
    if (!context.mounted) return;
  }
  if (!context.mounted) return;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Unable to open $uri. Please call (206) 919-6886.')),
  );
}
