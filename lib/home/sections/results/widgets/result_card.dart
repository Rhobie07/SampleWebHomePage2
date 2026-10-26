import 'package:flutter/material.dart';
import 'package:marci_metzger_homes/shared/animation/motion.dart';
import 'package:marci_metzger_homes/shared/theme/app_colors.dart';
import 'package:marci_metzger_homes/shared/widgets/site_button.dart';
import 'package:marci_metzger_homes/shared/widgets/site_button_kind.dart';
import 'package:marci_metzger_homes/shared/widgets/site_image.dart';

class ResultCard extends StatefulWidget {
  const ResultCard({
    super.key,
    required this.number,
    required this.category,
    required this.image,
    required this.imageLabel,
    required this.title,
    required this.description,
    required this.action,
    required this.onTap,
  });
  final String number;
  final String category;
  final String image;
  final String imageLabel;
  final String title;
  final String description;
  final String action;
  final VoidCallback onTap;

  @override
  State<ResultCard> createState() => _ResultCardState();
}

class _ResultCardState extends State<ResultCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final narrow = MediaQuery.sizeOf(context).width < 850;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AnimatedScale(
              scale: _hovered && !reduceMotion(context) ? 1.025 : 1,
              duration: reduceMotion(context)
                  ? Duration.zero
                  : const Duration(milliseconds: 450),
              child: SiteImage(
                widget.image,
                label: widget.imageLabel,
                width: double.infinity,
                height: narrow ? 260 : 230,
              ),
            ),
          ),
          const SizedBox(height: 28),
          Text(
            '${widget.number} / ${widget.category.toUpperCase()}',
            style: const TextStyle(
              fontSize: 10,
              letterSpacing: 1.7,
              color: Color(0xFFC6D3B8),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            widget.title,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: AppColors.cream,
              fontSize: 34,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            widget.description,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: const Color(0xFFCFD9C9),
              fontSize: 16,
              height: 1.9,
            ),
          ),
          if (!narrow) const Spacer(),
          const SizedBox(height: 20),
          SiteButton(
            label: widget.action,
            onPressed: widget.onTap,
            kind: SiteButtonKind.lightText,
          ),
        ],
      ),
    );
  }
}
