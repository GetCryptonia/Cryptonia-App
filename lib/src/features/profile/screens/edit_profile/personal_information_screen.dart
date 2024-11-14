import 'package:cryptonia/src/core/local/page_navigation.dart';
import 'package:cryptonia/src/features/profile/providers/profile_provider.dart';
import 'package:cryptonia/src/features/profile/screens/delete_account/delete_account_bottom_sheet.dart';
import 'package:cryptonia/src/features/profile/screens/edit_profile/change_email.dart';
import 'package:cryptonia/src/features/profile/screens/edit_profile/select_avatar.dart';
import 'package:cryptonia/src/features/profile/widgets/personal_info_row.dart';
import 'package:cryptonia/src/features/profile/widgets/profile_action_tile.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({super.key});

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, profileProv, _) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: const Text('Personal Information'),
            backgroundColor: AppColors.kContainerBg,
          ),
          body: Padding(
            padding: AppConstants.kScaffoldPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.kContainerBg,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 16),
                            InkWell(
                              onTap: () => PageNavigation.pushPage(
                                  context, const SelectAvatar()),
                              child: CircleAvatar(
                                radius: 36,
                                backgroundColor: AppColors.kTextColor,
                                backgroundImage: AssetImage(
                                    profileProv.profile?.avatar ??
                                        'assets/images/avatars/1.png'),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Tap to change photo',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: AppColors.kHintText),
                            ),
                            const SizedBox(height: 32),
                            PersonalInfoRow(
                              title: 'Username',
                              value: profileProv.profile?.username ?? '--',
                            ),
                            const Divider(),
                            PersonalInfoRow(
                              title: 'First Name',
                              value: profileProv.profile?.firstName ?? '--',
                            ),
                            const Divider(),
                            PersonalInfoRow(
                              title: 'Last Name',
                              value: profileProv.profile?.lastName ?? '--',
                            ),
                            const Divider(),
                            PersonalInfoRow(
                              title: 'Email',
                              value: profileProv.profile?.email ?? '--',
                              icon: 'assets/svgs/profile/edit.svg',
                              iconTapped: () => PageNavigation.pushPage(
                                  context, const ChangeEmail()),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.kContainerBg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ProfileActionTile(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return const DeleteAccountBottomSheet();
                        },
                      );
                    },
                    title: 'Delete Account',
                    trailingIcon: null,
                    iconColor: AppColors.kRedCross,
                    icon: 'assets/svgs/profile/delete.svg',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
