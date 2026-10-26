import 'package:flutter/material.dart';
import 'package:marci_metzger_homes/home/sections/gallery/gallery_photos.dart';
import 'package:marci_metzger_homes/shared/animation/motion.dart';
import 'package:marci_metzger_homes/shared/theme/app_colors.dart';

class GalleryPagination extends StatelessWidget {
  const GalleryPagination({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: galleryPhotos.length * 48.0,
        height: 48,
        child: Row(
          children: [
            for (var index = 0; index < galleryPhotos.length; index++)
              Expanded(
                child: _PhotoBar(
                  index: index,
                  isSelected: index == selectedIndex,
                  onPressed: () => onSelected(index),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _PhotoBar extends StatefulWidget {
  const _PhotoBar({
    required this.index,
    required this.isSelected,
    required this.onPressed,
  });

  final int index;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  State<_PhotoBar> createState() => _PhotoBarState();
}

class _PhotoBarState extends State<_PhotoBar> {
  bool _hovered = false;
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final photo = galleryPhotos[widget.index];
    final highlighted = _hovered || _focused;
    return Semantics(
      button: true,
      selected: widget.isSelected,
      label:
          'Show photo ${widget.index + 1} of ${galleryPhotos.length}. ${photo.label}',
      onTap: widget.onPressed,
      child: ExcludeSemantics(
        child: Tooltip(
          message: photo.caption,
          excludeFromSemantics: true,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onPressed,
              onHover: (value) => setState(() => _hovered = value),
              onFocusChange: (value) => setState(() => _focused = value),
              borderRadius: BorderRadius.circular(8),
              hoverColor: Colors.transparent,
              focusColor: AppColors.forest.withValues(alpha: .05),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _focused ? AppColors.forest : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: AnimatedContainer(
                    duration: reduceMotion(context)
                        ? Duration.zero
                        : motionDuration,
                    curve: Curves.easeOutCubic,
                    width: widget.isSelected
                        ? 36
                        : highlighted
                        ? 28
                        : 20,
                    height: highlighted ? 6 : 4,
                    decoration: BoxDecoration(
                      color: widget.isSelected || highlighted
                          ? AppColors.forest
                          : AppColors.olive,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
