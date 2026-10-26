import 'package:flutter/material.dart';

class GalleryControl extends StatelessWidget {
  const GalleryControl({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: label,
      onPressed: onPressed,
      icon: Icon(icon, size: 22),
      style: ButtonStyle(
        minimumSize: const WidgetStatePropertyAll(Size(48, 48)),
        foregroundColor: const WidgetStatePropertyAll(Colors.white),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          return Colors.white.withValues(
            alpha: states.contains(WidgetState.hovered) ? .16 : .06,
          );
        }),
        side: WidgetStateProperty.resolveWith((states) {
          return BorderSide(
            color: states.contains(WidgetState.focused)
                ? Colors.white
                : Colors.white24,
            width: states.contains(WidgetState.focused) ? 2 : 1,
          );
        }),
      ),
    );
  }
}
