import 'package:flutter/material.dart';
import 'package:marci_metzger_homes/shared/layout/section_width.dart';
import 'package:marci_metzger_homes/shared/theme/app_colors.dart';

import 'widgets/sales_metric.dart';

class SalesHighlightsSection extends StatelessWidget {
  const SalesHighlightsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final mobile = MediaQuery.sizeOf(context).width < 1000;
    const metrics = [
      ('~30', 'Years of real estate experience'),
      ('\$28.5M', 'Closed sales in 2021'),
      ('~90', 'Clients helped in 2021'),
    ];
    final values = [
      for (var i = 0; i < metrics.length; i++)
        Expanded(
          child: SalesMetric(
            value: metrics[i].$1,
            label: metrics[i].$2,
            isCompact: mobile,
            showDivider: !mobile || i > 0,
          ),
        ),
    ];
    return ColoredBox(
      color: AppColors.sage,
      child: SectionWidth(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: mobile ? 32 : 44),
          child: mobile
              ? Column(
                  children: [
                    Text(
                      'Local roots. Real results.',
                      style: TextStyle(
                        fontFamily: 'Cormorant',
                        fontSize: 26,
                        color: AppColors.forest,
                      ),
                    ),
                    const SizedBox(height: 28),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: values,
                    ),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Local roots.\nReal results.',
                        style: TextStyle(
                          fontFamily: 'Cormorant',
                          fontSize: 32,
                          height: 1.1,
                          color: AppColors.forest,
                        ),
                      ),
                    ),
                    ...values,
                  ],
                ),
        ),
      ),
    );
  }
}
