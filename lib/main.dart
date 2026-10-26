import 'package:flutter/material.dart';

import 'home/home_page.dart';
import 'shared/theme/site_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized().ensureSemantics();
  runApp(const MarciHomesApp());
}

class MarciHomesApp extends StatelessWidget {
  const MarciHomesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marci Metzger Homes | Pahrump, Nevada',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.build(),
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        scrollbars: false,
      ),
      home: const HomePage(),
    );
  }
}
