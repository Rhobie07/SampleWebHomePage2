import 'package:flutter/material.dart';
import 'package:marci_metzger_homes/shared/theme/app_colors.dart';
import 'package:marci_metzger_homes/shared/widgets/site_image.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({super.key, required this.service, required this.index});
  final ({String image, String title, String label, String description})
  service;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SiteImage(
          service.image,
          label: service.label,
          height: 250,
          width: double.infinity,
          radius: 8,
        ),
        const SizedBox(height: 28),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                service.title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                '0${index + 1}',
                style: const TextStyle(
                  fontSize: 11,
                  letterSpacing: 1,
                  color: AppColors.olive,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(service.description, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}
