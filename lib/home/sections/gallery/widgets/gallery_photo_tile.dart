import 'package:flutter/material.dart';
import 'package:marci_metzger_homes/home/sections/gallery/gallery_photos.dart';
import 'package:marci_metzger_homes/shared/animation/motion.dart';
import 'package:marci_metzger_homes/shared/theme/app_colors.dart';
import 'package:marci_metzger_homes/shared/widgets/site_image.dart';

class GalleryPhotoTile extends StatefulWidget {
  const GalleryPhotoTile({
    super.key,
    required this.index,
    required this.onOpen,
  });

  final int index;
  final VoidCallback onOpen;

  @override
  State<GalleryPhotoTile> createState() => _GalleryPhotoTileState();
}

class _GalleryPhotoTileState extends State<GalleryPhotoTile> {
  bool _hovered = false;
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final photo = galleryPhotos[widget.index];
    final active = _hovered || _focused;
    final duration = reduceMotion(context) ? Duration.zero : motionDuration;
    return Semantics(
      button: true,
      label:
          'Open photo ${widget.index + 1} of ${galleryPhotos.length}. ${photo.label}',
      onTap: widget.onOpen,
      child: ExcludeSemantics(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Material(
            color: AppColors.forest,
            child: InkWell(
              onTap: widget.onOpen,
              onHover: (value) => setState(() => _hovered = value),
              onFocusChange: (value) => setState(() => _focused = value),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  AnimatedScale(
                    scale: active && !reduceMotion(context) ? 1.035 : 1,
                    duration: duration,
                    curve: Curves.easeOutCubic,
                    child: SiteImage(photo.file, label: photo.label),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [.4, 1],
                        colors: [Colors.transparent, Color(0xD9101C15)],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: 20,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
                            photo.caption,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              height: 1.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        AnimatedOpacity(
                          opacity: active ? 1 : .7,
                          duration: duration,
                          child: const Icon(
                            Icons.open_in_full,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_focused)
                    Positioned.fill(
                      child: IgnorePointer(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white, width: 3),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
