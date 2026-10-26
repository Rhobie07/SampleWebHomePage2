import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marci_metzger_homes/home/sections/gallery/gallery_photos.dart';
import 'package:marci_metzger_homes/home/sections/gallery/widgets/gallery_control.dart';
import 'package:marci_metzger_homes/home/sections/gallery/widgets/gallery_thumbnail.dart';
import 'package:marci_metzger_homes/shared/animation/motion.dart';
import 'package:marci_metzger_homes/shared/widgets/site_image.dart';

class GalleryLightbox extends StatefulWidget {
  const GalleryLightbox({super.key, required this.initialIndex});

  final int initialIndex;

  @override
  State<GalleryLightbox> createState() => _GalleryLightboxState();
}

class _GalleryLightboxState extends State<GalleryLightbox> {
  final _thumbnailController = ScrollController();
  late int _index = widget.initialIndex;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _revealThumbnail());
  }

  @override
  void dispose() {
    _thumbnailController.dispose();
    super.dispose();
  }

  void _selectPhoto(int index) {
    setState(() => _index = index);
    _revealThumbnail();
  }

  void _movePhoto(int direction) {
    _selectPhoto((_index + direction) % galleryPhotos.length);
  }

  void _revealThumbnail() {
    if (!mounted || !_thumbnailController.hasClients) return;
    final position = _thumbnailController.position;
    final offset = (_index * 88 - (position.viewportDimension - 80) / 2).clamp(
      0.0,
      position.maxScrollExtent,
    );
    if (reduceMotion(context)) {
      _thumbnailController.jumpTo(offset);
    } else {
      _thumbnailController.animateTo(
        offset,
        duration: motionDuration,
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final photo = galleryPhotos[_index];
    return Dialog.fullscreen(
      backgroundColor: const Color(0xFF101914),
      child: CallbackShortcuts(
        bindings: {
          const SingleActivator(LogicalKeyboardKey.arrowLeft): () =>
              _movePhoto(-1),
          const SingleActivator(LogicalKeyboardKey.arrowRight): () =>
              _movePhoto(1),
          const SingleActivator(LogicalKeyboardKey.escape): () =>
              Navigator.of(context).pop(),
        },
        child: Focus(
          autofocus: true,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(
                MediaQuery.sizeOf(context).width < 600 ? 16 : 24,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1400),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Photo gallery',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Semantics(
                            liveRegion: true,
                            child: Text(
                              '${(_index + 1).toString().padLeft(2, '0')} / 07',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          GalleryControl(
                            label: 'Close gallery',
                            icon: Icons.close,
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: SizedBox.expand(
                          child: SiteImage(
                            photo.file,
                            label: photo.label,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          GalleryControl(
                            label: 'Previous photo',
                            icon: Icons.arrow_back,
                            onPressed: () => _movePhoto(-1),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Semantics(
                              liveRegion: true,
                              child: Text(
                                photo.caption,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          GalleryControl(
                            label: 'Next photo',
                            icon: Icons.arrow_forward,
                            onPressed: () => _movePhoto(1),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 64,
                        child: ListView.separated(
                          controller: _thumbnailController,
                          scrollDirection: Axis.horizontal,
                          itemCount: galleryPhotos.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 8),
                          itemBuilder: (context, index) => GalleryThumbnail(
                            index: index,
                            isSelected: _index == index,
                            onPressed: () => _selectPhoto(index),
                          ),
                        ),
                      ),
                    ],
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
