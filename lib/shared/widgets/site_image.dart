import 'package:flutter/material.dart';

class SiteImage extends StatelessWidget {
  const SiteImage(
    this.name, {
    super.key,
    required this.label,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.radius = 0,
  });
  final String name;
  final String label;
  final double? height;
  final double? width;
  final BoxFit fit;
  final Alignment alignment;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.asset(
        'assets/images/$name',
        semanticLabel: label,
        height: height,
        width: width,
        fit: fit,
        alignment: alignment,
        filterQuality: FilterQuality.medium,
      ),
    );
  }
}
