import 'package:flutter/material.dart';
import 'package:marci_metzger_homes/shared/theme/app_colors.dart';

class PrivacyDialog extends StatelessWidget {
  const PrivacyDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.cream,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: const Text(
        'Your privacy matters.',
        style: TextStyle(
          fontFamily: 'Cormorant',
          fontSize: 36,
          color: AppColors.forest,
        ),
      ),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 440),
        child: const SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'This website does not run analytics or set tracking cookies. '
                'Your privacy-notice preference is saved only in your browser. '
                'Contact messages are prepared in your email app, not stored here.',
              ),
              SizedBox(height: 24),
              Text(
                'Original website cookie notice',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.forest,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '“This website uses cookies. We use cookies to analyze website '
                'traffic and optimize your website experience. By accepting our '
                'use of cookies, your data will be aggregated with all other user data.”',
              ),
              SizedBox(height: 16),
              Text(
                'That analytics policy belongs to the original website. '
                'No analytics service has been carried into this redesign.',
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
