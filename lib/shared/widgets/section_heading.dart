import 'package:flutter/material.dart';
import 'package:marci_metzger_homes/shared/theme/app_colors.dart';
import 'package:marci_metzger_homes/shared/widgets/eyebrow.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    required this.eyebrow,
    required this.title,
    this.description,
    this.light = false,
  });
  final String eyebrow;
  final String title;
  final String? description;
  final bool light;

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 760;
    final heading = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Eyebrow(eyebrow, light: light),
        const SizedBox(height: 20),
        Semantics(
          header: true,
          child: Text(
            title,
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              fontSize: compact ? 46 : 64,
              color: light ? AppColors.cream : AppColors.ink,
            ),
          ),
        ),
      ],
    );
    final body = Text(
      description ?? '',
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
        color: light ? const Color(0xFFD0DBCD) : AppColors.muted,
      ),
    );
    if (compact || description == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heading,
          if (description != null) ...[const SizedBox(height: 24), body],
        ],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(flex: 3, child: heading),
        const SizedBox(width: 64),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: body,
          ),
        ),
      ],
    );
  }
}
