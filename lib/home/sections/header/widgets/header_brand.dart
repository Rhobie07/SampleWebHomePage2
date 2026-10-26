import 'package:flutter/material.dart';
import 'package:marci_metzger_homes/shared/theme/app_colors.dart';

class HeaderBrand extends StatelessWidget {
  const HeaderBrand({super.key, required this.width, this.light = false});
  final double width;
  final bool light;

  @override
  Widget build(BuildContext context) {
    final image = Image.asset(
      'assets/images/brand.png',
      width: width,
      height: width * .27,
      fit: BoxFit.contain,
      excludeFromSemantics: true,
    );
    return light
        ? ColorFiltered(
            colorFilter: const ColorFilter.mode(
              AppColors.cream,
              BlendMode.srcIn,
            ),
            child: image,
          )
        : image;
  }
}
