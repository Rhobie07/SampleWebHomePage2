import 'package:flutter/material.dart';
import 'package:marci_metzger_homes/shared/theme/app_colors.dart';

class SalesMetric extends StatelessWidget {
  const SalesMetric({
    super.key,
    required this.value,
    required this.label,
    required this.isCompact,
    required this.showDivider,
  });
  final String value;
  final String label;
  final bool isCompact;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: isCompact ? (showDivider ? 16 : 0) : 48),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: showDivider ? const Color(0xFFC7CEBA) : Colors.transparent,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Cormorant',
              fontSize: isCompact ? 38 : 54,
              height: 1,
              color: AppColors.forest,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(
              fontSize: isCompact ? 10 : 11,
              height: 1.7,
              color: AppColors.muted,
            ),
          ),
        ],
      ),
    );
  }
}
