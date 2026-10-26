import 'package:flutter/material.dart';
import 'package:marci_metzger_homes/shared/theme/app_colors.dart';

class HeroLocation extends StatelessWidget {
  const HeroLocation({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.location_on_outlined,
          size: 16,
          color: Color(0xFFDEE5D1),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            'MOUNTAIN FALLS · PAHRUMP, NEVADA',
            style: TextStyle(
              color: AppColors.cream.withValues(alpha: .88),
              fontSize: 9,
              letterSpacing: 1.5,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}
