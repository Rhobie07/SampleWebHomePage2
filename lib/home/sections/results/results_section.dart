import 'package:flutter/material.dart';
import 'package:marci_metzger_homes/shared/animation/reveal.dart';
import 'package:marci_metzger_homes/shared/layout/site_section.dart';
import 'package:marci_metzger_homes/shared/theme/app_colors.dart';
import 'package:marci_metzger_homes/shared/widgets/section_heading.dart';

import 'widgets/result_card.dart';

class ResultsSection extends StatelessWidget {
  const ResultsSection({
    super.key,
    required this.onContact,
    required this.onSearch,
  });
  final VoidCallback onContact;
  final VoidCallback onSearch;

  @override
  Widget build(BuildContext context) {
    final narrow = MediaQuery.sizeOf(context).width < 850;
    final cards = [
      ResultCard(
        number: '01',
        category: 'Proven results',
        image: 'sales.jpg',
        imageLabel: 'A residential neighborhood with room to grow',
        title: 'Top residential sales.\nLast five years.',
        description:
            'We helped nearly 90 clients in 2021, and closed \$28.5 million in sales!\n\n'
            'Our team works hard every day to grow and learn, so that we may continue '
            'to excel in our market. Our clients deserve our best, and we want to '
            'make sure our best is better every year.',
        action: 'Work with our team',
        onTap: onContact,
      ),
      ResultCard(
        number: '02',
        category: 'For sellers',
        image: 'selling.jpg',
        imageLabel: 'Real estate marketing designed to get your home sold',
        title: 'Don’t just list it.\nGet it sold.',
        description:
            'Get it SOLD! We exhaust every avenue to ensure our listings '
            'are at the fingertips of every possible buyer, getting you top dollar '
            'for your home.',
        action: 'Let’s sell your home',
        onTap: onContact,
      ),
      ResultCard(
        number: '03',
        category: 'Guide to buyers',
        image: 'buying.jpg',
        imageLabel: 'An inviting home and the start of a new chapter',
        title: 'A pro on your side.\nEvery step of the way.',
        description:
            'Nobody knows the market like we do. Enjoy having a pro at '
            'your service. Market analysis, upgrades lists, contractors on speed '
            'dial, and more!',
        action: 'Find your next home',
        onTap: onSearch,
      ),
    ];
    return SiteSection(
      color: AppColors.forest,
      child: Reveal(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeading(
              eyebrow: 'Get it sold',
              title: 'Big moves.\nBetter together.',
              description:
                  'Buying, selling, or just exploring what’s next? '
                  'We bring the experience. You bring the dream.',
              light: true,
            ),
            const SizedBox(height: 48),
            if (narrow)
              Column(
                children: [
                  for (var i = 0; i < cards.length; i++) ...[
                    cards[i],
                    if (i < cards.length - 1) const SizedBox(height: 48),
                  ],
                ],
              )
            else
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (var i = 0; i < cards.length; i++) ...[
                      Expanded(child: cards[i]),
                      if (i < cards.length - 1) const SizedBox(width: 32),
                    ],
                  ],
                ),
              ),
            const SizedBox(height: 40),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: AppColors.cream.withValues(alpha: .18),
                  ),
                ),
              ),
              child: const Text(
                'Sales highlights as reported on Marci’s original website. '
                'Sales volume and client figures refer to 2021.',
                style: TextStyle(
                  color: Color(0xFFBAC9B3),
                  fontSize: 11,
                  height: 1.8,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
