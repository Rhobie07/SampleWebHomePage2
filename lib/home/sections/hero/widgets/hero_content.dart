import 'package:flutter/material.dart';
import 'package:marci_metzger_homes/shared/layout/section_width.dart';
import 'package:marci_metzger_homes/shared/theme/app_colors.dart';
import 'package:marci_metzger_homes/shared/widgets/eyebrow.dart';
import 'package:marci_metzger_homes/shared/widgets/site_button.dart';
import 'package:marci_metzger_homes/shared/widgets/site_button_kind.dart';

import 'hero_location.dart';

class HeroContent extends StatelessWidget {
  const HeroContent({super.key, required this.onSearch, required this.onAbout});
  final VoidCallback onSearch;
  final VoidCallback onAbout;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final mobile = width < 600;
    final fontSize = mobile
        ? (width < 380 ? 68.0 : 76.0)
        : width < 1000
        ? 98.0
        : 126.0;
    return SectionWidth(
      child: Padding(
        padding: EdgeInsets.only(
          top: mobile ? 168 : 206,
          bottom: mobile ? 76 : 100,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Eyebrow(
              'Marci Metzger · The Ridge Realty Group',
              light: true,
            ),
            SizedBox(height: mobile ? 28 : 32),
            Semantics(
              header: true,
              child: Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(text: 'This is your\n'),
                    TextSpan(
                      text: 'kind of place.',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: const Color(0xFFE2E8D1),
                        letterSpacing: mobile ? -2 : -3,
                      ),
                    ),
                  ],
                ),
                style: TextStyle(
                  fontFamily: 'Cormorant',
                  fontSize: fontSize,
                  color: AppColors.cream,
                  fontWeight: FontWeight.w400,
                  letterSpacing: mobile ? -1.8 : -3.2,
                  height: .98,
                ),
              ),
            ),
            const SizedBox(height: 28),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Text(
                'Wide-open skies. A community that feels like home.\n'
                'Discover your next chapter in Pahrump, Nevada.',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: const Color(0xFFF0F2E9),
                  height: 1.85,
                ),
              ),
            ),
            const SizedBox(height: 36),
            Wrap(
              spacing: 32,
              runSpacing: 16,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                SiteButton(
                  label: 'Find your dream home',
                  onPressed: onSearch,
                  kind: SiteButtonKind.light,
                ),
                SiteButton(
                  label: 'Meet your local expert',
                  onPressed: onAbout,
                  kind: SiteButtonKind.lightText,
                  icon: Icons.arrow_forward,
                ),
              ],
            ),
            if (mobile) ...[const SizedBox(height: 56), const HeroLocation()],
          ],
        ),
      ),
    );
  }
}
