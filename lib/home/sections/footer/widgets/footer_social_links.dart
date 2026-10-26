import 'package:flutter/material.dart';

import 'social_icon_button.dart';

const _socialLinks = [
  ('Facebook', 'https://www.facebook.com/MarciHomes/', 'social-facebook.png'),
  (
    'Instagram',
    'https://www.instagram.com/marcimetzger_theridge/',
    'social-instagram.png',
  ),
  (
    'LinkedIn',
    'https://www.linkedin.com/in/marci-metzger-30642496/',
    'social-linkedin.png',
  ),
  (
    'Yelp',
    'https://www.yelp.com/biz/xr3yQN_m2SgO0R_7S6p62w',
    'social-yelp.png',
  ),
];

class FooterSocialLinks extends StatelessWidget {
  const FooterSocialLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 12,
      runSpacing: 12,
      children: [
        for (final social in _socialLinks)
          SocialIconButton(
            label: social.$1,
            url: social.$2,
            asset: 'assets/images/${social.$3}',
          ),
      ],
    );
  }
}
