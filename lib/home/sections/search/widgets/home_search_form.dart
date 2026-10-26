import 'package:flutter/material.dart';
import 'package:marci_metzger_homes/home/sections/search/widgets/search_price.dart';
import 'package:marci_metzger_homes/home/sections/search/widgets/search_select.dart';
import 'package:marci_metzger_homes/home/sections/search/widgets/search_summary.dart';
import 'package:marci_metzger_homes/shared/theme/app_colors.dart';
import 'package:marci_metzger_homes/shared/widgets/site_button.dart';

class HomeSearchForm extends StatefulWidget {
  const HomeSearchForm({super.key});

  @override
  State<HomeSearchForm> createState() => _HomeSearchFormState();
}

class _HomeSearchFormState extends State<HomeSearchForm> {
  static const _locations = [
    'Any',
    'Alamo',
    'Alton',
    'Amargosa Valley',
    'Beatty',
    'Beryl',
    'Blue Diamond',
    'Boulder City',
    'Brian Head',
    'Cal Nev Ari',
    'Caliente',
    'Cedar City',
    'Cold Creek',
    'Crystal',
    'Duck Creek Village',
    'Dyer',
    'Elko',
    'Ely',
    'Goldfield',
    'Goodsprings',
    'Hatch',
    'Henderson',
    'Indian Springs',
    'Jean',
    'Las Vegas',
    'Laughlin',
    'Logandale',
    'Mc Gill',
    'Mesquite',
    'Moapa',
    'Mount Charleston',
    'Mountain Springs',
    'Nelson',
    'North Las Vegas',
    'Other',
    'Overton',
    'Pahrump',
    'Palm Gardens',
    'Panaca',
    'Parowan',
    'Pioche',
    'Ruth',
    'Sandy Valley',
    'Searchlight',
    'Tonopah',
  ];
  static const _types = [
    'Any',
    'Land',
    'Residential Lease',
    'High Rise',
    'Residential',
  ];
  static const _sortOptions = [
    'Newest',
    'Oldest',
    'Price: low to high',
    'Price: high to low',
    'Bedrooms: low to high',
    'Bedrooms: high to low',
    'Baths: low to high',
    'Baths: high to low',
  ];
  static const _bedOptions = [
    'Any',
    'Studio',
    '1+',
    '2+',
    '3+',
    '4+',
    '5+',
    '6+',
  ];
  static const _bathOptions = ['Any', '1+', '2+', '3+', '4+', '5+', '6+'];

  final _formKey = GlobalKey<FormState>();
  final _minimumPrice = TextEditingController();
  final _maximumPrice = TextEditingController();
  String _location = 'Pahrump';
  String _type = 'Any';
  String _sort = 'Newest';
  String _bedrooms = 'Any';
  String _baths = 'Any';

  @override
  void dispose() {
    _minimumPrice.dispose();
    _maximumPrice.dispose();
    super.dispose();
  }

  String? _validatePrice(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    final text = value.trim();
    final price = double.tryParse(text);
    if (!RegExp(r'^\d+(\.\d{1,2})?$').hasMatch(text) ||
        price == null ||
        !price.isFinite) {
      return 'Enter a valid price';
    }
    return null;
  }

  String? _validateMaximum(String? value) {
    final error = _validatePrice(value);
    if (error != null) return error;
    final minimum = double.tryParse(_minimumPrice.text.trim());
    final maximum = double.tryParse(value?.trim() ?? '');
    if (minimum != null && maximum != null && minimum > maximum) {
      return 'Must be at least min price';
    }
    return null;
  }

  void _exploreHomes() {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    final criteria = <String, String>{
      'Location': _location,
      'Type': _type,
      'Sort by': _sort,
      'Bedrooms': _bedrooms,
      'Baths': _baths,
      'Min price': _minimumPrice.text.trim().isEmpty
          ? 'No minimum'
          : '\$${_minimumPrice.text.trim()}',
      'Max price': _maximumPrice.text.trim().isEmpty
          ? 'No maximum'
          : '\$${_maximumPrice.text.trim()}',
    };
    showDialog<void>(
      context: context,
      builder: (context) => SearchSummary(criteria: criteria),
    );
  }

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 700;
    return Container(
      padding: EdgeInsets.all(compact ? 24 : 32),
      decoration: BoxDecoration(
        color: AppColors.cream,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: .7)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .16),
            blurRadius: 40,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                final columns = constraints.maxWidth >= 760 ? 4 : 2;
                final gap = compact ? 16.0 : 24.0;
                final fieldWidth =
                    (constraints.maxWidth - gap * (columns - 1)) / columns;
                final fields = <Widget>[
                  SearchSelect(
                    label: 'Location',
                    value: _location,
                    options: _locations,
                    onChanged: (value) => setState(() => _location = value),
                  ),
                  SearchSelect(
                    label: 'Type',
                    value: _type,
                    options: _types,
                    onChanged: (value) => setState(() => _type = value),
                  ),
                  SearchSelect(
                    label: 'Sort By',
                    value: _sort,
                    options: _sortOptions,
                    onChanged: (value) => setState(() => _sort = value),
                  ),
                  SearchSelect(
                    label: 'Bedrooms',
                    value: _bedrooms,
                    options: _bedOptions,
                    onChanged: (value) => setState(() => _bedrooms = value),
                  ),
                  SearchSelect(
                    label: 'Baths',
                    value: _baths,
                    options: _bathOptions,
                    onChanged: (value) => setState(() => _baths = value),
                  ),
                  SearchPrice(
                    label: 'Min Price',
                    controller: _minimumPrice,
                    validator: _validatePrice,
                    onChanged: (_) {
                      if (_maximumPrice.text.isNotEmpty) {
                        _formKey.currentState?.validate();
                      }
                    },
                  ),
                  SearchPrice(
                    label: 'Max Price',
                    controller: _maximumPrice,
                    validator: _validateMaximum,
                    onSubmitted: (_) => _exploreHomes(),
                  ),
                ];
                return Wrap(
                  spacing: gap,
                  runSpacing: 24,
                  children: [
                    for (final field in fields)
                      SizedBox(width: fieldWidth, child: field),
                  ],
                );
              },
            ),
            const SizedBox(height: 24),
            const Divider(height: 1),
            const SizedBox(height: 24),
            LayoutBuilder(
              builder: (context, constraints) {
                final note = Text(
                  'Browse live listings on Zillow, or share your '
                  'wish list directly with Marci.',
                  style: Theme.of(context).textTheme.bodyLarge,
                );
                final button = SiteButton(
                  label: 'Explore homes',
                  onPressed: _exploreHomes,
                  icon: Icons.search,
                  expand: constraints.maxWidth < 620,
                );
                if (constraints.maxWidth < 620) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [button, const SizedBox(height: 16), note],
                  );
                }
                return Row(
                  children: [
                    Expanded(child: note),
                    const SizedBox(width: 32),
                    button,
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
