import 'package:flutter/material.dart';

import 'widgets/hero_background.dart';
import 'widgets/hero_content.dart';
import 'widgets/hero_scroll_cue.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key, required this.onSearch, required this.onAbout});
  final VoidCallback onSearch;
  final VoidCallback onAbout;

  @override
  Widget build(BuildContext context) {
    final mobile = MediaQuery.sizeOf(context).width < 600;
    return Stack(
      children: [
        const Positioned.fill(child: HeroBackground()),
        ConstrainedBox(
          constraints: BoxConstraints(minHeight: mobile ? 820 : 840),
          child: HeroContent(onSearch: onSearch, onAbout: onAbout),
        ),
        if (!mobile)
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: HeroScrollCue(onDiscover: onAbout),
          ),
      ],
    );
  }
}
