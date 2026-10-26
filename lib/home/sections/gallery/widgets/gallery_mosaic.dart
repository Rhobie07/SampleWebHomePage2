import 'package:flutter/material.dart';
import 'package:marci_metzger_homes/home/sections/gallery/gallery_photos.dart';
import 'package:marci_metzger_homes/home/sections/gallery/widgets/gallery_lightbox.dart';
import 'package:marci_metzger_homes/home/sections/gallery/widgets/gallery_photo_tile.dart';

class GalleryMosaic extends StatelessWidget {
  const GalleryMosaic({super.key});

  void _openPhoto(BuildContext context, int index) {
    showDialog<void>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: .9),
      builder: (context) => GalleryLightbox(initialIndex: index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        if (width >= 1000) {
          final leadHeight = (width * .41).clamp(420.0, 530.0);
          return Column(
            children: [
              SizedBox(
                height: leadHeight,
                child: Row(
                  children: [
                    Expanded(
                      flex: 8,
                      child: GalleryPhotoTile(
                        index: 0,
                        onOpen: () => _openPhoto(context, 0),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          for (var index = 1; index < 3; index++) ...[
                            if (index > 1) const SizedBox(height: 24),
                            Expanded(
                              child: GalleryPhotoTile(
                                index: index,
                                onOpen: () => _openPhoto(context, index),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (
                    var index = 3;
                    index < galleryPhotos.length;
                    index++
                  ) ...[
                    if (index > 3) const SizedBox(width: 24),
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1.18,
                        child: GalleryPhotoTile(
                          index: index,
                          onOpen: () => _openPhoto(context, index),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          );
        }
        final columns = width >= 560 ? 2 : 1;
        const gap = 16.0;
        final cardWidth = (width - gap * (columns - 1)) / columns;
        return Column(
          children: [
            AspectRatio(
              aspectRatio: columns == 2 ? 1.75 : 1.25,
              child: GalleryPhotoTile(
                index: 0,
                onOpen: () => _openPhoto(context, 0),
              ),
            ),
            const SizedBox(height: gap),
            Wrap(
              spacing: gap,
              runSpacing: gap,
              children: [
                for (var index = 1; index < galleryPhotos.length; index++)
                  SizedBox(
                    width: cardWidth,
                    child: AspectRatio(
                      aspectRatio: 1.4,
                      child: GalleryPhotoTile(
                        index: index,
                        onOpen: () => _openPhoto(context, index),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}
