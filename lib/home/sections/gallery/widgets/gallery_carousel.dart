import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marci_metzger_homes/home/sections/gallery/gallery_photos.dart';
import 'package:marci_metzger_homes/home/sections/gallery/widgets/gallery_lightbox.dart';
import 'package:marci_metzger_homes/home/sections/gallery/widgets/gallery_photo_tile.dart';
import 'package:marci_metzger_homes/shared/animation/motion.dart';
import 'package:marci_metzger_homes/shared/theme/app_colors.dart';

class GalleryCarousel extends StatelessWidget {
  const GalleryCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        return _CarouselViewport(
          viewportFraction: width < 600
              ? .72
              : width < 1000
              ? .7
              : .6,
          height: (width * .56).clamp(280.0, 480.0),
        );
      },
    );
  }
}

class _CarouselViewport extends StatefulWidget {
  const _CarouselViewport({
    required this.viewportFraction,
    required this.height,
  });

  final double viewportFraction;
  final double height;

  @override
  State<_CarouselViewport> createState() => _CarouselViewportState();
}

class _CarouselViewportState extends State<_CarouselViewport>
    with WidgetsBindingObserver {
  static const _interval = Duration(seconds: 10);
  static const _transition = Duration(milliseconds: 650);
  static final _photoCount = galleryPhotos.length;

  late PageController _controller;
  int _selectedPage = _photoCount;
  Timer? _timer;
  bool _isPlaying = true;
  bool _isHovered = false;
  bool _isFocused = false;
  bool _isDragging = false;
  bool _isMoving = false;
  bool _isLightboxOpen = false;
  bool _isAppActive = true;
  bool _reducedMotion = false;

  int get _photoIndex => _selectedPage % _photoCount;

  bool get _canAutoplay =>
      _isPlaying &&
      !_reducedMotion &&
      !_isHovered &&
      !_isFocused &&
      !_isDragging &&
      !_isLightboxOpen &&
      _isAppActive;

  @override
  void initState() {
    super.initState();
    _controller = _createController();
    final binding = WidgetsBinding.instance;
    _isAppActive =
        binding.lifecycleState == null ||
        binding.lifecycleState == AppLifecycleState.resumed;
    binding.addObserver(this);
  }

  PageController _createController() => PageController(
    initialPage: _selectedPage,
    viewportFraction: widget.viewportFraction,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _reducedMotion = reduceMotion(context);
    if (_reducedMotion) _isPlaying = false;
    _syncTimer();
  }

  @override
  void didUpdateWidget(covariant _CarouselViewport oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.viewportFraction != widget.viewportFraction) {
      final previousController = _controller;
      _selectedPage = _photoCount + _photoIndex;
      _controller = _createController();
      _isMoving = false;
      _isDragging = false;
      previousController.dispose();
      _syncTimer(restart: true);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _isAppActive = state == AppLifecycleState.resumed;
    _syncTimer();
  }

  void _syncTimer({bool restart = false}) {
    if (restart || !_canAutoplay) {
      _timer?.cancel();
      _timer = null;
    }
    if (_canAutoplay) {
      _timer ??= Timer.periodic(_interval, (_) => _move(1, automatic: true));
    }
  }

  Future<void> _move(int direction, {bool automatic = false}) async {
    if (_isMoving ||
        _isDragging ||
        !_controller.hasClients ||
        !_controller.position.hasContentDimensions) {
      return;
    }
    if (!automatic) _syncTimer(restart: true);
    final controller = _controller;
    final target = controller.page!.round() + direction;
    _isMoving = true;
    try {
      if (_reducedMotion) {
        controller.jumpToPage(target);
      } else {
        await controller.animateToPage(
          target,
          duration: _transition,
          curve: Curves.easeInOutCubic,
        );
      }
    } finally {
      if (mounted && identical(controller, _controller)) {
        _isMoving = false;
        _recenterLoop();
      }
    }
  }

  void _recenterLoop() {
    if (!mounted ||
        !_controller.hasClients ||
        !_controller.position.hasContentDimensions) {
      return;
    }
    final page = _controller.page!.round();
    if (page < _photoCount || page >= _photoCount * 2) {
      // Identical neighboring copies let the loop reset without a visible jump.
      _controller.jumpToPage(_photoCount + page % _photoCount);
    }
  }

  bool _handleScroll(ScrollNotification notification) {
    if (notification is ScrollStartNotification &&
        notification.dragDetails != null) {
      _isDragging = true;
      _syncTimer();
    } else if (notification is ScrollEndNotification) {
      _isDragging = false;
      _syncTimer();
      WidgetsBinding.instance.addPostFrameCallback((_) => _recenterLoop());
    }
    return false;
  }

  Future<void> _openPhoto(int index) async {
    _isLightboxOpen = true;
    _syncTimer();
    try {
      await showDialog<void>(
        context: context,
        barrierColor: Colors.black.withValues(alpha: .9),
        builder: (context) => GalleryLightbox(initialIndex: index),
      );
    } finally {
      if (mounted) {
        _isLightboxOpen = false;
        _syncTimer();
      }
    }
  }

  void _togglePlayback() {
    setState(() => _isPlaying = !_isPlaying);
    _syncTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        _isHovered = true;
        _syncTimer();
      },
      onExit: (_) {
        _isHovered = false;
        _syncTimer();
      },
      child: CallbackShortcuts(
        bindings: {
          const SingleActivator(LogicalKeyboardKey.arrowLeft): () => _move(-1),
          const SingleActivator(LogicalKeyboardKey.arrowRight): () => _move(1),
        },
        child: Focus(
          onFocusChange: (focused) {
            _isFocused = focused;
            _syncTimer();
          },
          child: Column(
            children: [
              SizedBox(
                height: widget.height,
                child: NotificationListener<ScrollNotification>(
                  onNotification: _handleScroll,
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: _photoCount * 3,
                    allowImplicitScrolling: true,
                    onPageChanged: (page) =>
                        setState(() => _selectedPage = page),
                    itemBuilder: (context, page) {
                      return AnimatedBuilder(
                        animation: _controller,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Semantics(
                            selected: page == _selectedPage,
                            child: RepaintBoundary(
                              child: GalleryPhotoTile(
                                index: page % _photoCount,
                                onOpen: () => _openPhoto(page % _photoCount),
                              ),
                            ),
                          ),
                        ),
                        builder: (context, child) {
                          final position =
                              _controller.hasClients &&
                                  _controller.position.hasContentDimensions
                              ? _controller.page ?? _selectedPage.toDouble()
                              : _selectedPage.toDouble();
                          final distance = (position - page).abs().clamp(
                            0.0,
                            1.0,
                          );
                          return Transform.scale(
                            scale: 1 - distance * .16,
                            child: child,
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _CarouselControls(
                index: _photoIndex,
                isPlaying: _isPlaying,
                reducedMotion: _reducedMotion,
                onPrevious: () => _move(-1),
                onNext: () => _move(1),
                onTogglePlayback: _togglePlayback,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CarouselControls extends StatelessWidget {
  const _CarouselControls({
    required this.index,
    required this.isPlaying,
    required this.reducedMotion,
    required this.onPrevious,
    required this.onNext,
    required this.onTogglePlayback,
  });

  final int index;
  final bool isPlaying;
  final bool reducedMotion;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onTogglePlayback;

  static const _buttonStyle = ButtonStyle(
    minimumSize: WidgetStatePropertyAll(Size(48, 48)),
    foregroundColor: WidgetStatePropertyAll(AppColors.forest),
    side: WidgetStatePropertyAll(BorderSide(color: AppColors.line)),
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '${(index + 1).toString().padLeft(2, '0')} / '
          '${galleryPhotos.length.toString().padLeft(2, '0')}',
          semanticsLabel:
              'Gallery photo ${index + 1} of ${galleryPhotos.length}',
          style: const TextStyle(
            color: AppColors.forest,
            fontSize: 13,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),
        const Spacer(),
        IconButton(
          tooltip: 'Previous gallery photo',
          onPressed: onPrevious,
          style: _buttonStyle,
          icon: const Icon(Icons.arrow_back, size: 20),
        ),
        const SizedBox(width: 8),
        IconButton(
          tooltip: reducedMotion
              ? 'Autoplay off: reduced motion'
              : isPlaying
              ? 'Pause gallery autoplay'
              : 'Play gallery autoplay',
          onPressed: reducedMotion ? null : onTogglePlayback,
          style: _buttonStyle,
          icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow, size: 20),
        ),
        const SizedBox(width: 8),
        IconButton(
          tooltip: 'Next gallery photo',
          onPressed: onNext,
          style: _buttonStyle,
          icon: const Icon(Icons.arrow_forward, size: 20),
        ),
      ],
    );
  }
}
