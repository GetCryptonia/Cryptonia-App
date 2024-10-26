import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileActionTile extends StatelessWidget {
  final String icon;
  final String title;
  final String? trailingIcon;
  final Widget? trailingPrefix;
  final VoidCallback onTap;
  final Color iconColor;
  const ProfileActionTile({
    super.key,
    required this.icon,
    required this.title,
    this.trailingPrefix,
    required this.onTap,
    this.iconColor = AppColors.kProfileIcon,
    this.trailingIcon = 'assets/svgs/profile/arrow-right.svg',
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.all(0),
      leading: SvgPicture.asset(
        icon,
        width: 20,
        height: 20,
        colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
      ),
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailingPrefix != null) trailingPrefix!,
          if (trailingIcon != null)
            SvgPicture.asset(
              trailingIcon!,
              width: 16,
              height: 16,
              colorFilter: const ColorFilter.mode(
                  AppColors.kProfileIcon, BlendMode.srcIn),
            ),
        ],
      ),
    );
  }
}
