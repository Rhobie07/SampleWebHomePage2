import 'package:flutter/material.dart';
import 'package:marci_metzger_homes/home/sections/gallery/gallery_photos.dart';
import 'package:marci_metzger_homes/shared/widgets/site_image.dart';

class GalleryThumbnail extends StatefulWidget {
  const GalleryThumbnail({
    super.key,
    required this.index,
    required this.isSelected,
    required this.onPressed,
  });

  final int index;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  State<GalleryThumbnail> createState() => _GalleryThumbnailState();
}

class _GalleryThumbnailState extends State<GalleryThumbnail> {
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final photo = galleryPhotos[widget.index];
    return Semantics(
      button: true,
      selected: widget.isSelected,
      label: 'View photo ${widget.index + 1}. ${photo.label}',
      onTap: widget.onPressed,
      child: ExcludeSemantics(
        child: SizedBox(
          width: 80,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onPressed,
              onFocusChange: (value) => setState(() => _focused = value),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _focused
                        ? Colors.white
                        : widget.isSelected
                        ? const Color(0xFFB4C99C)
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: SiteImage(photo.file, label: photo.label, radius: 4),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
