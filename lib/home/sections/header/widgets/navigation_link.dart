import 'package:flutter/material.dart';
import 'package:marci_metzger_homes/shared/animation/motion.dart';

class NavigationLink extends StatefulWidget {
  const NavigationLink({
    super.key,
    required this.label,
    required this.isActive,
    required this.color,
    required this.onTap,
  });
  final String label;
  final bool isActive;
  final Color color;
  final VoidCallback onTap;

  @override
  State<NavigationLink> createState() => _NavigationLinkState();
}

class _NavigationLinkState extends State<NavigationLink> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onHover: (value) => setState(() => _hover = value),
      borderRadius: BorderRadius.circular(3),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.label,
              style: TextStyle(
                color: widget.color,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: reduceMotion(context) ? Duration.zero : motionDuration,
              width: _hover ? 32 : 20,
              height: 2,
              decoration: BoxDecoration(
                color: widget.isActive || _hover
                    ? widget.color
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
