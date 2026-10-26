import 'package:flutter/material.dart';
import 'package:marci_metzger_homes/shared/theme/app_colors.dart';

class FooterBrand extends StatelessWidget {
  const FooterBrand({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ColorFiltered(
          colorFilter: const ColorFilter.mode(AppColors.cream, BlendMode.srcIn),
          child: Image.asset(
            'assets/images/brand.png',
            width: 236,
            height: 76,
            fit: BoxFit.contain,
            semanticLabel: 'Marci Metzger Homes',
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Good people. Great places. Your next chapter.',
          style: TextStyle(
            color: Color(0xFFD4DECC),
            fontFamily: 'Cormorant',
            fontSize: 25,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'PAHRUMP, NEVADA · THE RIDGE REALTY GROUP',
          style: TextStyle(
            fontSize: 9,
            letterSpacing: 1.6,
            color: Color(0xFFB7C7AE),
          ),
        ),
      ],
    );
  }
}
