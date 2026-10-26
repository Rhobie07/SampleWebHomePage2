import 'package:flutter/material.dart';
import 'package:marci_metzger_homes/shared/animation/motion.dart';
import 'package:marci_metzger_homes/shared/theme/app_colors.dart';
import 'package:marci_metzger_homes/shared/widgets/site_button_kind.dart';

class SiteButton extends StatefulWidget {
  const SiteButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.kind = SiteButtonKind.primary,
    this.icon = Icons.north_east,
    this.expand = false,
  });
  final String label;
  final VoidCallback onPressed;
  final SiteButtonKind kind;
  final IconData? icon;
  final bool expand;

  @override
  State<SiteButton> createState() => _SiteButtonState();
}

class _SiteButtonState extends State<SiteButton> {
  bool _hovered = false;
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final active = _hovered || _focused;
    final isText =
        widget.kind == SiteButtonKind.text ||
        widget.kind == SiteButtonKind.lightText;
    final light =
        widget.kind == SiteButtonKind.light ||
        widget.kind == SiteButtonKind.lightText;
    final outline = widget.kind == SiteButtonKind.outline;
    final foreground = light && !isText
        ? AppColors.forest
        : light
        ? AppColors.cream
        : isText || outline
        ? AppColors.forest
        : AppColors.cream;
    final background = isText || outline
        ? Colors.transparent
        : light
        ? (active ? Colors.white : AppColors.cream)
        : active
        ? const Color(0xFF365341)
        : AppColors.forest;
    final duration = reduceMotion(context) ? Duration.zero : motionDuration;
    return AnimatedContainer(
      duration: duration,
      curve: Curves.easeOutCubic,
      transform: Matrix4.translationValues(
        0,
        active && !isText && !reduceMotion(context) ? -2 : 0,
        0,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(isText ? 0 : 4),
        border: isText
            ? Border(
                bottom: BorderSide(
                  color: foreground.withValues(alpha: active ? .9 : .35),
                ),
              )
            : Border.all(
                color: _focused
                    ? AppColors.olive
                    : outline
                    ? AppColors.olive
                    : background,
                width: 1,
              ),
        boxShadow: !isText && !outline
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: active ? .17 : .08),
                  blurRadius: active ? 22 : 10,
                  offset: Offset(0, active ? 8 : 3),
                ),
              ]
            : [],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onPressed,
          onHover: (value) => setState(() => _hovered = value),
          onFocusChange: (value) => setState(() => _focused = value),
          borderRadius: BorderRadius.circular(isText ? 0 : 4),
          hoverColor: Colors.transparent,
          focusColor: foreground.withValues(alpha: .08),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: isText ? 48 : 56),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isText ? 0 : 24,
                vertical: isText ? 10 : 14,
              ),
              child: Row(
                mainAxisSize: widget.expand
                    ? MainAxisSize.max
                    : MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      widget.label,
                      style: TextStyle(
                        color: foreground,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        height: 1.5,
                      ),
                    ),
                  ),
                  if (widget.icon != null) ...[
                    SizedBox(width: isText ? 20 : 28),
                    AnimatedSlide(
                      duration: duration,
                      offset: active ? const Offset(.12, -.12) : Offset.zero,
                      child: Icon(widget.icon, size: 19, color: foreground),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
