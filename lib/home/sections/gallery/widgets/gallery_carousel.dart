import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:marci_metzger_homes/home/sections/gallery/gallery_photos.dart';
import 'package:marci_metzger_homes/home/sections/gallery/widgets/gallery_lightbox.dart';
import 'package:marci_metzger_homes/home/sections/gallery/widgets/gallery_photo_tile.dart';
import 'package:marci_metzger_homes/home/sections/gallery/widgets/gallery_pagination.dart';
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
  static final _pauseAction = CustomSemanticsAction(
    label: 'Pause automatic slideshow',
  );
  static final _resumeAction = CustomSemanticsAction(
    label: 'Resume automatic slideshow',
  );

  late final _pauseActions = <CustomSemanticsAction, VoidCallback>{
    _pauseAction: _togglePlayback,
  };
  late final _resumeActions = <CustomSemanticsAction, VoidCallback>{
    _resumeAction: _togglePlayback,
  };

  late PageController _controller;
  int _selectedPage = _photoCount;
  Timer? _timer;
  bool _isPlaying = true;
  bool _isDragging = false;
  bool _isMoving = false;
  bool _isLightboxOpen = false;
  bool _isAppActive = true;
  bool _reducedMotion = false;

  int get _photoIndex => _selectedPage % _photoCount;

  bool get _canAutoplay =>
      _isPlaying &&
      !_reducedMotion &&
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

  void _selectPhoto(int index) {
    var distance = (index - _photoIndex) % _photoCount;
    if (distance > _photoCount ~/ 2) distance -= _photoCount;
    if (distance == 0) {
      _syncTimer(restart: true);
      return;
    }
    _move(distance);
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
    if (_reducedMotion) return;
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
    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.arrowLeft): () => _move(-1),
        const SingleActivator(LogicalKeyboardKey.arrowRight): () => _move(1),
        if (!_reducedMotion)
          const SingleActivator(
            LogicalKeyboardKey.space,
            includeRepeats: false,
          ): _togglePlayback,
      },
      child: Semantics(
        container: true,
        label: 'Property photo carousel',
        value:
            'Photo ${_photoIndex + 1} of $_photoCount. '
            '${_isPlaying && !_reducedMotion ? 'Autoplay on' : 'Autoplay off'}.',
        hint: _reducedMotion
            ? 'Automatic playback is off for reduced motion. '
                  'Use arrow keys or the photo bars to browse.'
            : 'Use arrow keys to browse. '
                  'Press Space to pause or resume automatic playback.',
        customSemanticsActions: _reducedMotion
            ? null
            : _isPlaying
            ? _pauseActions
            : _resumeActions,
        child: Focus(
          child: Column(
            children: [
              SizedBox(
                height: widget.height,
                child: Stack(
                  clipBehavior: Clip.none,
                  fit: StackFit.expand,
                  children: [
                    NotificationListener<ScrollNotification>(
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
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Semantics(
                                selected: page == _selectedPage,
                                child: RepaintBoundary(
                                  child: GalleryPhotoTile(
                                    index: page % _photoCount,
                                    onOpen: () =>
                                        _openPhoto(page % _photoCount),
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: _CarouselArrow(
                          label: 'Previous gallery photo',
                          icon: Icons.chevron_left,
                          onPressed: () => _move(-1),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: _CarouselArrow(
                          label: 'Next gallery photo',
                          icon: Icons.chevron_right,
                          onPressed: () => _move(1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              GalleryPagination(
                selectedIndex: _photoIndex,
                onSelected: _selectPhoto,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CarouselArrow extends StatelessWidget {
  const _CarouselArrow({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  static final _style = ButtonStyle(
    minimumSize: const WidgetStatePropertyAll(Size(48, 48)),
    fixedSize: const WidgetStatePropertyAll(Size(48, 48)),
    shape: const WidgetStatePropertyAll(CircleBorder()),
    foregroundColor: const WidgetStatePropertyAll(AppColors.forest),
    backgroundColor: WidgetStateProperty.resolveWith(
      (states) =>
          states.contains(WidgetState.hovered) ? Colors.white : AppColors.cream,
    ),
    side: WidgetStateProperty.resolveWith(
      (states) => BorderSide(
        color: states.contains(WidgetState.focused)
            ? AppColors.forest
            : AppColors.line,
        width: states.contains(WidgetState.focused) ? 2 : 1,
      ),
    ),
    elevation: WidgetStateProperty.resolveWith(
      (states) =>
          states.contains(WidgetState.hovered) ||
              states.contains(WidgetState.focused)
          ? 6
          : 3,
    ),
    shadowColor: const WidgetStatePropertyAll(Color(0x33000000)),
    animationDuration: motionDuration,
  );
  static final _reducedStyle = _style.copyWith(
    animationDuration: Duration.zero,
  );

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      tooltip: label,
      onPressed: onPressed,
      style: reduceMotion(context) ? _reducedStyle : _style,
      icon: Icon(icon, size: 26),
    );
  }
}
