import 'package:flutter/material.dart';
import 'package:marci_metzger_homes/shared/animation/motion.dart';
import 'package:marci_metzger_homes/shared/navigation/open_site_url.dart';
import 'package:marci_metzger_homes/shared/theme/app_colors.dart';

class SocialIconButton extends StatelessWidget {
  const SocialIconButton({
    super.key,
    required this.label,
    required this.url,
    required this.asset,
  });

  final String label;
  final String url;
  final String asset;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: '$label (opens in a new tab)',
      onPressed: () => openSiteUrl(context, Uri.parse(url)),
      style: ButtonStyle(
        fixedSize: const WidgetStatePropertyAll(Size(48, 48)),
        padding: const WidgetStatePropertyAll(EdgeInsets.all(12)),
        shape: const WidgetStatePropertyAll(CircleBorder()),
        foregroundColor: WidgetStateProperty.resolveWith(
          (states) => _isActive(states) ? AppColors.forest : AppColors.cream,
        ),
        backgroundColor: WidgetStateProperty.resolveWith(
          (states) => _isActive(states)
              ? AppColors.cream
              : AppColors.cream.withValues(alpha: .04),
        ),
        side: WidgetStateProperty.resolveWith(
          (states) => BorderSide(
            color: AppColors.cream.withValues(
              alpha: _isActive(states) ? 1 : .3,
            ),
          ),
        ),
        elevation: WidgetStateProperty.resolveWith(
          (states) => _isActive(states) ? 4 : 0,
        ),
        shadowColor: WidgetStatePropertyAll(
          Colors.black.withValues(alpha: .18),
        ),
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        animationDuration: reduceMotion(context)
            ? Duration.zero
            : motionDuration,
      ),
      icon: ImageIcon(AssetImage(asset), size: 24),
    );
  }
}

bool _isActive(Set<WidgetState> states) =>
    states.contains(WidgetState.hovered) ||
    states.contains(WidgetState.focused) ||
    states.contains(WidgetState.pressed);
