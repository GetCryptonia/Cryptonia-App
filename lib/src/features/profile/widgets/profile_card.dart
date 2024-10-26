import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileCard extends StatelessWidget {
  final String avatar;
  final String email;
  final String username;
  final VoidCallback avatarTap;
  final VoidCallback editTap;
  const ProfileCard(
      {super.key,
      required this.avatar,
      required this.email,
      required this.username,
      required this.avatarTap,
      required this.editTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.kContainerBg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Account',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            leading: InkWell(
              onTap: avatarTap,
              child: CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.kTextColor,
                backgroundImage: AssetImage(avatar),
              ),
            ),
            title: Text(username),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  email,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppColors.kHintText),
                ),
                InkWell(
                  onTap: editTap,
                  child: SvgPicture.asset(
                    'assets/svgs/profile/edit.svg',
                    width: 24,
                    height: 24,
                    colorFilter: const ColorFilter.mode(
                        AppColors.kTextColor, BlendMode.srcIn),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
