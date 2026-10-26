import 'package:flutter/material.dart';
import 'package:marci_metzger_homes/shared/theme/app_colors.dart';

class FooterNavigation extends StatelessWidget {
  const FooterNavigation({super.key, required this.onNavigate});
  final ValueChanged<String> onNavigate;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: MediaQuery.sizeOf(context).width < 900
          ? WrapAlignment.start
          : WrapAlignment.end,
      spacing: 32,
      runSpacing: 8,
      children: [
        for (final item in [
          ('Find a home', 'search'),
          ('Sell with us', 'sell'),
          ('Meet Marci', 'about'),
          ('Let’s connect', 'contact'),
        ])
          TextButton(
            onPressed: () => onNavigate(item.$2),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.cream,
              padding: EdgeInsets.zero,
              minimumSize: const Size(48, 44),
            ),
            child: Text(item.$1, style: const TextStyle(fontSize: 12)),
          ),
      ],
    );
  }
}
