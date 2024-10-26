import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PersonalInfoRow extends StatelessWidget {
  final String title;
  final String value;
  final String? icon;
  final VoidCallback? iconTapped;
  const PersonalInfoRow({
    super.key,
    required this.title,
    required this.value,
    this.icon,
    this.iconTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColors.kHintText),
          ),
          const Spacer(),
          Text(value),
          if (icon != null)
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: InkWell(
                onTap: iconTapped,
                child: SvgPicture.asset(
                  icon!,
                  width: 16,
                  height: 16,
                  colorFilter: const ColorFilter.mode(
                      AppColors.kTextColor, BlendMode.srcIn),
                ),
              ),
            )
        ],
      ),
    );
  }
}
