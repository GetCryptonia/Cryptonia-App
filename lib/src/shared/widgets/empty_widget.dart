import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  final String image;
  final String title;
  final String body;
  const EmptyWidget(
      {super.key,
      required this.image,
      required this.title,
      required this.body});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          image,
          width: 140,
          height: 140,
        ),
        const SizedBox(height: 32),
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        Text(
          body,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: AppColors.kHintText),
        ),
      ],
    );
  }
}
