import 'package:flutter/material.dart';
import 'package:marci_metzger_homes/shared/theme/app_colors.dart';
import 'package:marci_metzger_homes/shared/widgets/eyebrow.dart';
import 'package:marci_metzger_homes/shared/widgets/site_button.dart';
import 'package:marci_metzger_homes/shared/widgets/site_button_kind.dart';

class AgentIntroduction extends StatelessWidget {
  const AgentIntroduction({super.key, required this.onContact});
  final VoidCallback onContact;

  @override
  Widget build(BuildContext context) {
    final narrow = MediaQuery.sizeOf(context).width < 800;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Eyebrow('Meet Marci Metzger'),
        const SizedBox(height: 24),
        Text(
          'Local knowledge.\nA personal connection.',
          style: Theme.of(
            context,
          ).textTheme.headlineLarge!.copyWith(fontSize: narrow ? 48 : 64),
        ),
        const SizedBox(height: 28),
        Text(
          'Your home is more than an address. It’s where your next chapter begins.',
          style: Theme.of(
            context,
          ).textTheme.bodyLarge!.copyWith(color: AppColors.ink),
        ),
        const SizedBox(height: 20),
        Text(
          'A Realtor for nearly three decades, Marci brings experience, care, and a genuine '
          'connection to the community to every move. Previously a licensed broker in '
          'Washington State, she now helps buyers and sellers find their place in Southern Nevada.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 28),
        Container(
          padding: const EdgeInsets.only(left: 24),
          decoration: const BoxDecoration(
            border: Border(left: BorderSide(color: AppColors.olive, width: 2)),
          ),
          child: Text(
            '“I love that small-town feeling that our community offers.”',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontSize: narrow ? 30 : 34,
              fontStyle: FontStyle.italic,
              color: AppColors.forest,
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Marci Metzger',
          style: TextStyle(
            fontFamily: 'Cormorant',
            fontSize: 34,
            fontStyle: FontStyle.italic,
            color: AppColors.forest,
          ),
        ),
        const SizedBox(height: 24),
        SiteButton(
          label: 'Let’s start a conversation',
          onPressed: onContact,
          kind: SiteButtonKind.text,
          icon: Icons.arrow_forward,
        ),
      ],
    );
  }
}
