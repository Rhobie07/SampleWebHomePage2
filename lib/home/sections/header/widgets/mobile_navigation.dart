import 'package:flutter/material.dart';
import 'package:marci_metzger_homes/home/navigation/home_navigation.dart';
import 'package:marci_metzger_homes/shared/navigation/open_site_url.dart';
import 'package:marci_metzger_homes/shared/theme/app_colors.dart';
import 'package:marci_metzger_homes/shared/widgets/eyebrow.dart';
import 'package:marci_metzger_homes/shared/widgets/site_button.dart';
import 'package:marci_metzger_homes/shared/widgets/site_button_kind.dart';

import 'header_brand.dart';

class MobileNavigation extends StatelessWidget {
  const MobileNavigation({super.key, required this.onNavigate});
  final ValueChanged<String> onNavigate;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.forest,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 18, 24, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const HeaderBrand(width: 190, light: true),
                    IconButton(
                      tooltip: 'Close navigation',
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, color: AppColors.cream),
                    ),
                  ],
                ),
                const SizedBox(height: 70),
                const Eyebrow('Your next chapter starts here', light: true),
                const SizedBox(height: 26),
                for (var i = 0; i < homeNavigation.length; i++)
                  InkWell(
                    onTap: () => onNavigate(homeNavigation[i].$2),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppColors.cream.withValues(alpha: .18),
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            '0${i + 1}',
                            style: const TextStyle(
                              fontSize: 10,
                              color: Color(0xFFAEBE9E),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              homeNavigation[i].$1,
                              style: const TextStyle(
                                fontFamily: 'Cormorant',
                                fontSize: 40,
                                color: AppColors.cream,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.north_east,
                            color: AppColors.cream,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 40),
                SiteButton(
                  label: '(206) 919-6886',
                  onPressed: () => openSiteUrl(
                    context,
                    Uri(scheme: 'tel', path: '2069196886'),
                  ),
                  kind: SiteButtonKind.lightText,
                  icon: Icons.phone_outlined,
                ),
                const SizedBox(height: 16),
                const Text(
                  'The Ridge Realty Group\nPahrump, Nevada',
                  style: TextStyle(
                    color: Color(0xFFCAD6C2),
                    fontSize: 13,
                    height: 1.8,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
