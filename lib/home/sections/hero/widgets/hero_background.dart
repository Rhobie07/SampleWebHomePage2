import 'package:flutter/material.dart';
import 'package:marci_metzger_homes/shared/theme/app_colors.dart';

class HeroBackground extends StatelessWidget {
  const HeroBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final mobile = MediaQuery.sizeOf(context).width < 600;
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/images/hero.jpg',
          fit: BoxFit.cover,
          alignment: mobile ? const Alignment(.35, 0) : const Alignment(0, .15),
          semanticLabel:
              'Mountain Falls pond and mountain views in Pahrump, Nevada',
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.forest.withValues(alpha: .78),
                AppColors.forest.withValues(alpha: .37),
                AppColors.forest.withValues(alpha: .12),
              ],
              stops: const [0, .55, 1],
            ),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: .12),
                Colors.transparent,
                AppColors.forest.withValues(alpha: .48),
              ],
              stops: const [0, .5, 1],
            ),
          ),
        ),
      ],
    );
  }
}
