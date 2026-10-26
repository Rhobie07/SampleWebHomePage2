import 'package:flutter/material.dart';
import 'package:marci_metzger_homes/shared/layout/section_width.dart';
import 'package:marci_metzger_homes/shared/theme/app_colors.dart';

class SiteSection extends StatelessWidget {
  const SiteSection({
    super.key,
    required this.child,
    this.color,
    this.verticalPadding,
  });
  final Widget child;
  final Color? color;
  final double? verticalPadding;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: color ?? AppColors.cream,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical:
              verticalPadding ??
              (MediaQuery.sizeOf(context).width < 700 ? 64 : 104),
        ),
        child: SectionWidth(child: child),
      ),
    );
  }
}
