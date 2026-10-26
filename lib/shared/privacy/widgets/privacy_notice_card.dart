import 'package:flutter/material.dart';
import 'package:marci_metzger_homes/shared/theme/app_colors.dart';

class PrivacyNoticeCard extends StatelessWidget {
  const PrivacyNoticeCard({
    super.key,
    required this.onDismiss,
    required this.onShowDetails,
  });
  final VoidCallback onDismiss;
  final VoidCallback onShowDetails;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 360),
        child: Material(
          color: AppColors.cream,
          elevation: 12,
          shadowColor: AppColors.forest.withValues(alpha: .2),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.line),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.fromLTRB(22, 12, 12, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.shield_outlined,
                      size: 17,
                      color: AppColors.olive,
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        'Your privacy, respected.',
                        style: TextStyle(
                          color: AppColors.forest,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    IconButton(
                      tooltip: 'Dismiss privacy notice',
                      onPressed: onDismiss,
                      icon: const Icon(Icons.close, size: 17),
                    ),
                  ],
                ),
                const Text(
                  'No analytics. No tracking cookies.',
                  style: TextStyle(fontSize: 12, color: AppColors.muted),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    TextButton(
                      onPressed: onDismiss,
                      child: const Text('Got it'),
                    ),
                    TextButton(
                      onPressed: onShowDetails,
                      child: const Text('Privacy details'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
