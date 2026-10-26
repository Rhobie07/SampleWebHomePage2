import 'package:flutter/material.dart';
import 'package:marci_metzger_homes/shared/theme/app_colors.dart';

class ExperienceBadge extends StatelessWidget {
  const ExperienceBadge({super.key, required this.isCompact});
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
      decoration: BoxDecoration(
        color: AppColors.cream,
        border: Border.all(color: AppColors.line),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.forest.withValues(alpha: .08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.handshake_outlined,
            color: AppColors.olive,
            size: 30,
          ),
          const SizedBox(width: 20),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Experience. With heart.',
                  style: TextStyle(
                    fontFamily: 'Cormorant',
                    fontSize: isCompact ? 25 : 27,
                    color: AppColors.forest,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 7),
                const Text(
                  'YOUR NEIGHBOR. YOUR REALTOR.',
                  style: TextStyle(
                    fontSize: 8,
                    letterSpacing: 1.6,
                    color: AppColors.muted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
