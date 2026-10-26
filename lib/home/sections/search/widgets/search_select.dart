import 'package:flutter/material.dart';
import 'package:marci_metzger_homes/home/sections/search/widgets/search_field_label.dart';
import 'package:marci_metzger_homes/shared/theme/app_colors.dart';

class SearchSelect extends StatelessWidget {
  const SearchSelect({
    super.key,
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  final String label;
  final String value;
  final List<String> options;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return SearchFieldLabel(
      label: label,
      child: DropdownButtonFormField<String>(
        initialValue: value,
        isExpanded: true,
        menuMaxHeight: 320,
        dropdownColor: AppColors.cream,
        style: const TextStyle(fontSize: 16, color: AppColors.ink),
        icon: const Icon(Icons.keyboard_arrow_down, size: 20),
        decoration: InputDecoration(
          semanticCounterText: label,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 16,
          ),
        ),
        selectedItemBuilder: (context) => [
          for (final option in options)
            Align(
              alignment: Alignment.centerLeft,
              child: Text(option, maxLines: 1, overflow: TextOverflow.ellipsis),
            ),
        ],
        items: [
          for (final option in options)
            DropdownMenuItem(value: option, child: Text(option)),
        ],
        onChanged: (value) {
          if (value != null) onChanged(value);
        },
      ),
    );
  }
}
