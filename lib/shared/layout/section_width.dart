import 'package:flutter/material.dart';

class SectionWidth extends StatelessWidget {
  const SectionWidth({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width < 600
            ? 24
            : width < 1100
            ? 40
            : 64,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: SizedBox(width: double.infinity, child: child),
        ),
      ),
    );
  }
}
