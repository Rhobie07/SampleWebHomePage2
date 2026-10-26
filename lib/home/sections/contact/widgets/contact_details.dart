import 'package:flutter/material.dart';
import 'package:marci_metzger_homes/shared/navigation/open_site_url.dart';
import 'package:marci_metzger_homes/shared/theme/app_colors.dart';
import 'package:marci_metzger_homes/shared/widgets/section_heading.dart';
import 'package:marci_metzger_homes/shared/widgets/site_button.dart';
import 'package:marci_metzger_homes/shared/widgets/site_button_kind.dart';

class ContactDetails extends StatelessWidget {
  const ContactDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeading(
          eyebrow: 'Let’s talk',
          title: 'Let’s make your next move a good one.',
        ),
        const SizedBox(height: 24),
        Text(
          'A question, a plan, or just the beginning of an idea. '
          'You don’t have to have it all figured out to get in touch.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 32),
        SiteButton(
          label: '(206) 919-6886',
          icon: Icons.phone_outlined,
          onPressed: () => openSiteUrl(context, Uri.parse('tel:+12069196886')),
        ),
        const SizedBox(height: 16),
        SiteButton(
          label: 'marcimetzger@gmail.com',
          kind: SiteButtonKind.text,
          icon: Icons.mail_outline,
          onPressed: () => openSiteUrl(
            context,
            Uri(scheme: 'mailto', path: 'marcimetzger@gmail.com'),
          ),
        ),
        const SizedBox(height: 32),
        const Divider(height: 1),
        const SizedBox(height: 32),
        const Text(
          'Marci Metzger - THE RIDGE REALTY GROUP',
          style: TextStyle(
            fontSize: 16,
            height: 1.6,
            fontWeight: FontWeight.w600,
            color: AppColors.ink,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          '3190 HW-160, Suite F\nPahrump, Nevada 89048\nUnited States',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 8),
        SiteButton(
          label: 'Get directions',
          kind: SiteButtonKind.text,
          trailingIcon: Image.asset(
            'assets/images/google-maps.png',
            width: 24,
            height: 24,
            fit: BoxFit.contain,
            excludeFromSemantics: true,
          ),
          onPressed: () => openSiteUrl(
            context,
            Uri.https('www.google.com', '/maps/search/', {
              'api': '1',
              'query':
                  'THE RIDGE REALTY GROUP 3190 HW-160 Suite F '
                  'Pahrump Nevada 89048 United States',
            }),
          ),
        ),
        const SizedBox(height: 24),
        const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 4),
              child: Icon(
                Icons.schedule_outlined,
                size: 20,
                color: AppColors.olive,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Open daily · 8 am–7 pm',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.75,
                  color: AppColors.ink,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Appointments outside these hours are available. Just call.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
