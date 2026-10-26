import 'package:flutter/material.dart';
import 'package:marci_metzger_homes/home/sections/search/widgets/search_field_label.dart';
import 'package:marci_metzger_homes/shared/theme/app_colors.dart';

class SearchPrice extends StatelessWidget {
  const SearchPrice({
    super.key,
    required this.label,
    required this.controller,
    required this.validator,
    this.onChanged,
    this.onSubmitted,
  });

  final String label;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return SearchFieldLabel(
      label: label,
      child: TextFormField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        textInputAction: onSubmitted == null
            ? TextInputAction.next
            : TextInputAction.done,
        style: const TextStyle(fontSize: 16, color: AppColors.ink),
        decoration: const InputDecoration(
          prefixText: '\$ ',
          hintText: 'Any',
          errorMaxLines: 3,
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        ),
        validator: validator,
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
      ),
    );
  }
}
