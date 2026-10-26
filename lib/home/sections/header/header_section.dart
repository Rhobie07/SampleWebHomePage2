import 'package:flutter/material.dart';
import 'package:marci_metzger_homes/home/navigation/home_navigation.dart';
import 'package:marci_metzger_homes/shared/animation/motion.dart';
import 'package:marci_metzger_homes/shared/layout/section_width.dart';
import 'package:marci_metzger_homes/shared/navigation/open_site_url.dart';
import 'package:marci_metzger_homes/shared/theme/app_colors.dart';

import 'widgets/header_brand.dart';
import 'widgets/navigation_link.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({
    super.key,
    required this.isScrolled,
    required this.active,
    required this.onNavigate,
    required this.onMenu,
  });
  final bool isScrolled;
  final String active;
  final ValueChanged<String> onNavigate;
  final VoidCallback onMenu;

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 1100;
    final mobile = MediaQuery.sizeOf(context).width < 900;
    final foreground = isScrolled ? AppColors.forest : AppColors.cream;
    return AnimatedContainer(
      duration: reduceMotion(context) ? Duration.zero : motionDuration,
      decoration: BoxDecoration(
        color: isScrolled ? AppColors.cream : Colors.transparent,
        boxShadow: isScrolled
            ? [
                BoxShadow(
                  color: AppColors.forest.withValues(alpha: .07),
                  blurRadius: 24,
                  offset: const Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: SectionWidth(
        child: Container(
          height: mobile ? 84 : 104,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isScrolled
                    ? AppColors.line
                    : Colors.white.withValues(alpha: .28),
              ),
            ),
          ),
          child: Row(
            children: [
              Semantics(
                link: true,
                label: 'Marci Metzger Homes, back to top',
                child: InkWell(
                  onTap: () => onNavigate('home'),
                  borderRadius: BorderRadius.circular(4),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: HeaderBrand(
                      width: mobile
                          ? 184
                          : compact
                          ? 190
                          : 228,
                      light: !isScrolled,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              if (!mobile) ...[
                for (final item in homeNavigation) ...[
                  NavigationLink(
                    label: item.$1,
                    isActive: active == item.$2,
                    color: foreground,
                    onTap: () => onNavigate(item.$2),
                  ),
                  SizedBox(width: compact ? 16 : 24),
                ],
                Container(
                  width: 1,
                  height: 28,
                  color: foreground.withValues(alpha: .22),
                ),
                SizedBox(width: compact ? 20 : 28),
                InkWell(
                  onTap: () => openSiteUrl(
                    context,
                    Uri(scheme: 'tel', path: '2069196886'),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      children: [
                        Icon(Icons.north_east, color: foreground, size: 19),
                        const SizedBox(width: 10),
                        Text(
                          '(206) 919-6886',
                          style: TextStyle(
                            color: foreground,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ] else ...[
                IconButton(
                  tooltip: 'Call Marci',
                  onPressed: () => openSiteUrl(
                    context,
                    Uri(scheme: 'tel', path: '2069196886'),
                  ),
                  icon: Icon(Icons.phone_outlined, size: 20, color: foreground),
                ),
                const SizedBox(width: 4),
                IconButton(
                  tooltip: 'Open navigation',
                  onPressed: onMenu,
                  icon: Icon(Icons.menu, size: 26, color: foreground),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
