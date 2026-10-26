import 'package:flutter/material.dart';
import 'package:marci_metzger_homes/shared/theme/app_colors.dart';
import 'package:marci_metzger_homes/shared/widgets/site_image.dart';

import 'experience_badge.dart';

class AgentPortrait extends StatelessWidget {
  const AgentPortrait({super.key});

  @override
  Widget build(BuildContext context) {
    final narrow = MediaQuery.sizeOf(context).width < 800;
    return Padding(
      padding: EdgeInsets.only(left: narrow ? 12 : 32, bottom: 26),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(240),
                bottom: Radius.circular(8),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.forest.withValues(alpha: .10),
                  blurRadius: 38,
                  offset: const Offset(0, 18),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(240),
                bottom: Radius.circular(8),
              ),
              child: SiteImage(
                'marci.jpg',
                label: 'Marci Metzger, your Pahrump Realtor',
                height: narrow ? 470 : 580,
                width: double.infinity,
                alignment: const Alignment(0, -.35),
              ),
            ),
          ),
          Positioned(
            bottom: -26,
            left: narrow ? -12 : -32,
            right: narrow ? 0 : null,
            child: ExperienceBadge(isCompact: narrow),
          ),
        ],
      ),
    );
  }
}
