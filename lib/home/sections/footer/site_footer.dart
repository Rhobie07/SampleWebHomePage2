import 'package:flutter/material.dart';
import 'package:marci_metzger_homes/shared/layout/site_section.dart';
import 'package:marci_metzger_homes/shared/theme/app_colors.dart';

import 'widgets/footer_brand.dart';
import 'widgets/footer_legal.dart';
import 'widgets/footer_navigation.dart';
import 'widgets/footer_social_links.dart';
import 'widgets/partner_badges.dart';

class SiteFooter extends StatelessWidget {
  const SiteFooter({super.key, required this.onNavigate});
  final ValueChanged<String> onNavigate;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final mobile = width < 900;
    return Column(
      children: [
        SiteSection(verticalPadding: 40, child: const PartnerBadges()),
        SiteSection(
          color: AppColors.forest,
          verticalPadding: mobile ? 48 : 64,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (mobile) ...[
                const FooterBrand(),
                const SizedBox(height: 32),
                FooterNavigation(onNavigate: onNavigate),
              ] else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(child: FooterBrand()),
                    const SizedBox(width: 48),
                    Expanded(child: FooterNavigation(onNavigate: onNavigate)),
                  ],
                ),
              const SizedBox(height: 40),
              const FooterSocialLinks(),
              const SizedBox(height: 32),
              Divider(height: 1, color: AppColors.cream.withValues(alpha: .18)),
              const SizedBox(height: 24),
              const FooterLegal(),
            ],
          ),
        ),
      ],
    );
  }
}
