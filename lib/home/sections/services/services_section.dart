import 'package:flutter/material.dart';
import 'package:marci_metzger_homes/shared/animation/reveal.dart';
import 'package:marci_metzger_homes/shared/layout/site_section.dart';
import 'package:marci_metzger_homes/shared/theme/app_colors.dart';
import 'package:marci_metzger_homes/shared/widgets/section_heading.dart';
import 'package:marci_metzger_homes/shared/widgets/site_button.dart';
import 'package:marci_metzger_homes/shared/widgets/site_button_kind.dart';

import 'widgets/service_card.dart';

const _services = [
  (
    image: 'service-1.jpg',
    title: 'Real estate\ndone right.',
    label: 'Real Estate Done Right',
    description:
        'Nervous about your property adventure? Don’t be. Whether you’re '
        'getting ready to buy or sell your residence, looking at investment '
        'properties, or just curious about the markets, our team ensures you '
        'get the best experience possible!',
  ),
  (
    image: 'service-2.jpg',
    title: 'Commercial &\nresidential.',
    label: 'Commercial and residential real estate',
    description:
        'Large or small, condo or mansion, we can find it and get it at '
        'the price that’s right. Fixer-uppers? Luxury? We can help with all of it! '
        'We live, work, and play in this community. Happy to help you find '
        'where to put your hard-earned dollars.',
  ),
  (
    image: 'service-3.jpg',
    title: 'Rely on\nexpertise.',
    label: 'Expert guidance on affordability, credit, and loan options',
    description:
        'If you have questions about affordability, credit, and loan '
        'options, trust us to connect you with the right people to get the '
        'answers you need in a timely fashion. We make sure you feel confident '
        'and educated every step of the way.',
  ),
];

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key, required this.onContact});
  final VoidCallback onContact;

  @override
  Widget build(BuildContext context) {
    final narrow = MediaQuery.sizeOf(context).width < 850;
    final cards = [
      for (var i = 0; i < _services.length; i++)
        ServiceCard(service: _services[i], index: i),
    ];
    return SiteSection(
      color: AppColors.sand,
      child: Reveal(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeading(
              eyebrow: 'Our services',
              title: 'Good guidance.\nEvery step of the way.',
              description:
                  'From first homes to new investments, we help you move '
                  'forward with clarity, confidence, and a little less worry.',
            ),
            const SizedBox(height: 48),
            if (narrow)
              Column(
                children: [
                  for (var i = 0; i < cards.length; i++) ...[
                    cards[i],
                    if (i < cards.length - 1) const SizedBox(height: 40),
                  ],
                ],
              )
            else
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 0; i < cards.length; i++) ...[
                    Expanded(child: cards[i]),
                    if (i < cards.length - 1) const SizedBox(width: 32),
                  ],
                ],
              ),
            const SizedBox(height: 48),
            Center(
              child: SiteButton(
                label: 'Let’s talk about your next move',
                onPressed: onContact,
                kind: SiteButtonKind.outline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
