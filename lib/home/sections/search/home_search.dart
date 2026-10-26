import 'package:flutter/material.dart';
import 'package:marci_metzger_homes/home/sections/search/widgets/home_search_form.dart';
import 'package:marci_metzger_homes/shared/animation/reveal.dart';
import 'package:marci_metzger_homes/shared/layout/section_width.dart';
import 'package:marci_metzger_homes/shared/theme/app_colors.dart';
import 'package:marci_metzger_homes/shared/widgets/section_heading.dart';
import 'package:marci_metzger_homes/shared/widgets/site_image.dart';

class HomeSearch extends StatelessWidget {
  const HomeSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 700;
    return Stack(
      children: [
        const Positioned.fill(
          child: SiteImage(
            'search.jpg',
            label: 'A sunlit home and garden in the Nevada desert',
          ),
        ),
        Positioned.fill(
          child: ColoredBox(color: AppColors.forest.withValues(alpha: .82)),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: compact ? 64 : 104),
          child: SectionWidth(
            child: Reveal(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeading(
                    eyebrow: 'Find your dream home',
                    title: 'A place for your\nnext chapter.',
                    description:
                        'Room to grow. Space to breathe. Start with '
                        'what matters to you, and let’s find where you belong.',
                    light: true,
                  ),
                  const SizedBox(height: 40),
                  const HomeSearchForm(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
