import 'package:flutter/material.dart';
import 'package:marci_metzger_homes/shared/layout/section_width.dart';
import 'package:marci_metzger_homes/shared/theme/app_colors.dart';

import 'hero_location.dart';

class HeroScrollCue extends StatelessWidget {
  const HeroScrollCue({super.key, required this.onDiscover});
  final VoidCallback onDiscover;

  @override
  Widget build(BuildContext context) {
    return SectionWidth(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const HeroLocation(),
          InkWell(
            onTap: onDiscover,
            borderRadius: BorderRadius.circular(30),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Text(
                    'SCROLL TO DISCOVER',
                    style: TextStyle(
                      fontSize: 9,
                      color: AppColors.cream.withValues(alpha: .85),
                      letterSpacing: 1.8,
                    ),
                  ),
                  const SizedBox(width: 20),
                  const Icon(Icons.south, color: AppColors.cream, size: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
