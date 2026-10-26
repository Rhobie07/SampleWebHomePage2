import 'package:flutter/material.dart';
import 'package:marci_metzger_homes/shared/animation/reveal.dart';
import 'package:marci_metzger_homes/shared/layout/site_section.dart';

import 'widgets/agent_introduction.dart';
import 'widgets/agent_portrait.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key, required this.onContact});
  final VoidCallback onContact;

  @override
  Widget build(BuildContext context) {
    final narrow = MediaQuery.sizeOf(context).width < 800;
    final introduction = AgentIntroduction(onContact: onContact);
    const portrait = AgentPortrait();
    return SiteSection(
      child: Reveal(
        child: narrow
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [portrait, const SizedBox(height: 52), introduction],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: introduction),
                  const SizedBox(width: 104),
                  const Expanded(child: portrait),
                ],
              ),
      ),
    );
  }
}
