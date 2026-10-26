import 'package:flutter/material.dart';
import 'package:marci_metzger_homes/home/sections/gallery/widgets/gallery_mosaic.dart';
import 'package:marci_metzger_homes/shared/animation/reveal.dart';
import 'package:marci_metzger_homes/shared/layout/site_section.dart';
import 'package:marci_metzger_homes/shared/theme/app_colors.dart';
import 'package:marci_metzger_homes/shared/widgets/section_heading.dart';
import 'package:marci_metzger_homes/shared/widgets/site_button.dart';
import 'package:marci_metzger_homes/shared/widgets/site_button_kind.dart';

class PropertyGallery extends StatelessWidget {
  const PropertyGallery({super.key, required this.onContact});

  final VoidCallback onContact;

  @override
  Widget build(BuildContext context) {
    return SiteSection(
      color: AppColors.cream,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Reveal(
            child: SectionHeading(
              eyebrow: 'Through our lens',
              title: 'A closer look at life here.',
              description:
                  'Open skies, welcoming spaces, and a different pace. '
                  'Explore our gallery photography of local homes and surroundings '
                  '— these photos are not active listings.',
            ),
          ),
          const SizedBox(height: 40),
          const GalleryMosaic(),
          const SizedBox(height: 32),
          SiteButton(
            label: 'Picture yourself here? Let’s talk',
            kind: SiteButtonKind.text,
            onPressed: onContact,
          ),
        ],
      ),
    );
  }
}
