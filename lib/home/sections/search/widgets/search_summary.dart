import 'package:flutter/material.dart';
import 'package:marci_metzger_homes/shared/navigation/open_site_url.dart';
import 'package:marci_metzger_homes/shared/theme/app_colors.dart';
import 'package:marci_metzger_homes/shared/widgets/eyebrow.dart';
import 'package:marci_metzger_homes/shared/widgets/site_button.dart';
import 'package:marci_metzger_homes/shared/widgets/site_button_kind.dart';

class SearchSummary extends StatelessWidget {
  const SearchSummary({super.key, required this.criteria});

  final Map<String, String> criteria;

  Uri get _emailUri {
    final body =
        'Hello Marci,\n\nI’d love your help finding my next home. '
        'Here is my wish list:\n\n'
        '${criteria.entries.map((entry) => '${entry.key}: ${entry.value}').join('\n')}'
        '\n\nPlease let me know what might be a good fit. Thank you!';
    return Uri(
      scheme: 'mailto',
      path: 'marcimetzger@gmail.com',
      query:
          'subject=${Uri.encodeComponent('My home wish list')}'
          '&body=${Uri.encodeComponent(body)}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      backgroundColor: AppColors.cream,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 620,
          maxHeight: MediaQuery.sizeOf(context).height * .88,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const Expanded(child: Eyebrow('Your next chapter')),
                  IconButton(
                    tooltip: 'Close search summary',
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                    constraints: const BoxConstraints(
                      minWidth: 48,
                      minHeight: 48,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Your home wish list.',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              Text(
                'A little clarity is a great place to start. Here’s what you’re looking for.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
              const Divider(height: 1),
              for (final entry in criteria.entries)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          entry.key,
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.muted,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          entry.value,
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.ink,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              const Divider(height: 1),
              const SizedBox(height: 24),
              Text(
                'Current listings open on Zillow. These criteria aren’t applied '
                'to Zillow; email your wish list to Marci for a personal search.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
              SiteButton(
                label: 'Browse current listings',
                expand: true,
                onPressed: () => openSiteUrl(
                  context,
                  Uri.parse('https://www.zillow.com/profile/marcimetzger'),
                ),
              ),
              const SizedBox(height: 16),
              SiteButton(
                label: 'Email my wish list',
                kind: SiteButtonKind.outline,
                icon: Icons.mail_outline,
                expand: true,
                onPressed: () => openSiteUrl(context, _emailUri),
              ),
              const SizedBox(height: 16),
              Text(
                'Your email app opens with all your criteria. Nothing is sent '
                'until you review and send it there. No email app? Contact Marci at:',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 8),
              const SelectableText(
                'marcimetzger@gmail.com',
                style: TextStyle(fontSize: 16, color: AppColors.forest),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
