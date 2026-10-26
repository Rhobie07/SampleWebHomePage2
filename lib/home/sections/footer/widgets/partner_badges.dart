import 'package:flutter/material.dart';
import 'package:marci_metzger_homes/shared/theme/app_colors.dart';
import 'package:marci_metzger_homes/shared/widgets/site_image.dart';

class PartnerBadges extends StatelessWidget {
  const PartnerBadges({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final smallBadges = width < 500;
    return Column(
      children: [
        const Text(
          'LOCAL ROOTS. PROFESSIONAL STANDARDS.',
          style: TextStyle(
            fontSize: 9,
            letterSpacing: 2,
            color: AppColors.muted,
          ),
        ),
        const SizedBox(height: 28),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: smallBadges ? 40 : 80,
          runSpacing: 24,
          children: [
            for (final badge in [
              ('ridge.png', 'The Ridge Realty Group', 66.0),
              ('equal-housing.png', 'Equal Housing Opportunity', 62.0),
              ('realtor.jpg', 'Realtor', 62.0),
              ('chamber.jpg', 'Pahrump Valley Chamber of Commerce', 90.0),
            ])
              SizedBox(
                width: smallBadges ? (width - 88) / 2 : badge.$3,
                child: ColorFiltered(
                  colorFilter: const ColorFilter.matrix([
                    .2126,
                    .7152,
                    .0722,
                    0,
                    0,
                    .2126,
                    .7152,
                    .0722,
                    0,
                    0,
                    .2126,
                    .7152,
                    .0722,
                    0,
                    0,
                    0,
                    0,
                    0,
                    1,
                    0,
                  ]),
                  child: SiteImage(
                    badge.$1,
                    label: badge.$2,
                    width: badge.$3,
                    height: 64,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
