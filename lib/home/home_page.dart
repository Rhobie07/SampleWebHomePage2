import 'package:flutter/material.dart';
import 'package:marci_metzger_homes/home/sections/header/header_section.dart';
import 'package:marci_metzger_homes/home/sections/header/widgets/mobile_navigation.dart';
import 'package:marci_metzger_homes/home/sections/hero/hero_section.dart';
import 'package:marci_metzger_homes/home/sections/highlights/sales_highlights_section.dart';

import '../shared/animation/motion.dart';
import 'sections/about/about_section.dart';
import 'sections/contact/contact_section.dart';
import 'sections/footer/site_footer.dart';
import 'sections/gallery/property_gallery.dart';
import 'sections/results/results_section.dart';
import 'sections/search/home_search.dart';
import 'sections/services/services_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  final _anchors = <String, GlobalKey>{
    for (final name in [
      'home',
      'about',
      'sell',
      'search',
      'gallery',
      'services',
      'contact',
    ])
      name: GlobalKey(),
  };
  bool _isScrolled = false;
  String _active = 'home';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateNavigation);
  }

  void _updateNavigation() {
    final scrolled = _scrollController.offset > 70;
    var active = 'home';
    for (final entry in _anchors.entries) {
      final box = entry.value.currentContext?.findRenderObject() as RenderBox?;
      if (box != null &&
          box.hasSize &&
          box.localToGlobal(Offset.zero).dy < 190) {
        if (entry.key == 'gallery' || entry.key == 'services') {
          active = 'search';
        } else {
          active = entry.key;
        }
      }
    }
    if (scrolled != _isScrolled || active != _active) {
      setState(() {
        _isScrolled = scrolled;
        _active = active;
      });
    }
  }

  void _goTo(String section) {
    final target = _anchors[section]?.currentContext;
    if (target == null) return;
    final box = target.findRenderObject() as RenderBox;
    final headerHeight = MediaQuery.sizeOf(context).width < 900 ? 84.0 : 104.0;
    final offset = section == 'home'
        ? 0.0
        : (_scrollController.offset +
                  box.localToGlobal(Offset.zero).dy -
                  headerHeight +
                  8)
              .clamp(0.0, _scrollController.position.maxScrollExtent);
    if (reduceMotion(context)) {
      _scrollController.jumpTo(offset);
    } else {
      _scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 750),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _openMenu() {
    showGeneralDialog<void>(
      context: context,
      barrierLabel: 'Close navigation',
      barrierDismissible: true,
      transitionDuration: reduceMotion(context)
          ? Duration.zero
          : const Duration(milliseconds: 300),
      pageBuilder: (dialogContext, _, _) => MobileNavigation(
        onNavigate: (section) {
          Navigator.of(dialogContext).pop();
          _goTo(section);
        },
      ),
      transitionBuilder: (context, animation, _, child) => SlideTransition(
        position: Tween(begin: const Offset(0, -.04), end: Offset.zero).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
        ),
        child: FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Scrollbar(
            controller: _scrollController,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  HeroSection(
                    key: _anchors['home'],
                    onSearch: () => _goTo('search'),
                    onAbout: () => _goTo('about'),
                  ),
                  const SalesHighlightsSection(),
                  AboutSection(
                    key: _anchors['about'],
                    onContact: () => _goTo('contact'),
                  ),
                  ResultsSection(
                    key: _anchors['sell'],
                    onContact: () => _goTo('contact'),
                    onSearch: () => _goTo('search'),
                  ),
                  HomeSearch(key: _anchors['search']),
                  PropertyGallery(
                    key: _anchors['gallery'],
                    onContact: () => _goTo('contact'),
                  ),
                  ServicesSection(
                    key: _anchors['services'],
                    onContact: () => _goTo('contact'),
                  ),
                  ContactSection(key: _anchors['contact']),
                  SiteFooter(onNavigate: _goTo),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: HeaderSection(
              isScrolled: _isScrolled,
              active: _active,
              onNavigate: _goTo,
              onMenu: _openMenu,
            ),
          ),
        ],
      ),
    );
  }
}
