import 'package:flutter/material.dart';
import 'package:marci_metzger_homes/shared/layout/site_section.dart';
import 'package:marci_metzger_homes/shared/theme/app_colors.dart';

import 'widgets/footer_social_links.dart';

class SiteFooter extends StatelessWidget {
  const SiteFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final mobile = MediaQuery.sizeOf(context).width < 900;
    return SiteSection(
      color: AppColors.forest,
      verticalPadding: mobile ? 48 : 64,
      child: const Column(
        children: [
          FooterSocialLinks(),
          SizedBox(height: 24),
          Text(
            '© 2026 MARCI METZGER. ALL RIGHTS RESERVED.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              height: 1.6,
              letterSpacing: .8,
              color: Color(0xFFB7C7AE),
            ),
          ),
        ],
      ),
    );
  }
}
