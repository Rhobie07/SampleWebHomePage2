import 'package:flutter/material.dart';
import 'package:marci_metzger_homes/home/sections/contact/widgets/contact_details.dart';
import 'package:marci_metzger_homes/home/sections/contact/widgets/contact_form.dart';
import 'package:marci_metzger_homes/shared/animation/reveal.dart';
import 'package:marci_metzger_homes/shared/layout/site_section.dart';
import 'package:marci_metzger_homes/shared/theme/app_colors.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SiteSection(
      color: AppColors.sage,
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 900) {
            return const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Reveal(child: ContactDetails()),
                SizedBox(height: 48),
                Reveal(child: ContactForm()),
              ],
            );
          }
          return const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Reveal(child: ContactDetails())),
              SizedBox(width: 80),
              Expanded(child: Reveal(child: ContactForm())),
            ],
          );
        },
      ),
    );
  }
}
