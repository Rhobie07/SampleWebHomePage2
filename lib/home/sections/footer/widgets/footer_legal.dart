import 'package:flutter/material.dart';
import 'package:marci_metzger_homes/shared/privacy/privacy_information.dart';

class FooterLegal extends StatelessWidget {
  const FooterLegal({super.key, required this.onBackToTop});
  final VoidCallback onBackToTop;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      spacing: 40,
      runSpacing: 16,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Text(
            '© 2026 MARCI METZGER. ALL RIGHTS RESERVED.',
            style: TextStyle(
              fontSize: 9,
              letterSpacing: .8,
              color: Color(0xFFB7C7AE),
            ),
          ),
        ),
        TextButton(
          onPressed: () => showCookieInformation(context),
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFFCDD8C4),
            padding: EdgeInsets.zero,
            minimumSize: const Size(48, 44),
          ),
          child: const Text(
            'Privacy & cookies',
            style: TextStyle(fontSize: 11),
          ),
        ),
        TextButton(
          onPressed: onBackToTop,
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFFCDD8C4),
            padding: EdgeInsets.zero,
            minimumSize: const Size(48, 44),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Back to top', style: TextStyle(fontSize: 11)),
              SizedBox(width: 12),
              Icon(Icons.north, size: 15),
            ],
          ),
        ),
      ],
    );
  }
}
