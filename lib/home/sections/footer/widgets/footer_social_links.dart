import 'package:flutter/material.dart';
import 'package:marci_metzger_homes/shared/navigation/open_site_url.dart';

const _socialLinks = [
  ('Facebook', 'https://www.facebook.com/MarciHomes/'),
  ('Instagram', 'https://www.instagram.com/marcimetzger_theridge/'),
  ('LinkedIn', 'https://www.linkedin.com/in/marci-metzger-30642496/'),
  ('Yelp', 'https://www.yelp.com/biz/xr3yQN_m2SgO0R_7S6p62w'),
];

class FooterSocialLinks extends StatelessWidget {
  const FooterSocialLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 24,
      runSpacing: 8,
      children: [
        for (final social in _socialLinks)
          TextButton(
            onPressed: () => openSiteUrl(context, Uri.parse(social.$2)),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFFD8E0CE),
              padding: EdgeInsets.zero,
              minimumSize: const Size(48, 44),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(social.$1, style: const TextStyle(fontSize: 12)),
                const SizedBox(width: 8),
                const Icon(Icons.north_east, size: 13),
              ],
            ),
          ),
      ],
    );
  }
}
