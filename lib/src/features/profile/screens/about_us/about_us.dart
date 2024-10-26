import 'package:cryptonia/src/features/profile/widgets/about_us_action_tile.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('About Us'),
        backgroundColor: AppColors.kContainerBg,
      ),
      body: ListView(
        padding: AppConstants.kScaffoldPadding,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.kContainerBg,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AboutUsActionTile(
                  title: 'Privacy Policy',
                  onTap: () async {
                    await launchUrl(
                        Uri.parse('https://getcryptonia.com/privacy-policy'));
                  },
                ),
                const Divider(),
                AboutUsActionTile(
                  title: 'Terms and Condition',
                  onTap: () async {
                    await launchUrl(
                        Uri.parse('https://getcryptonia.com/terms-of-use'));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
