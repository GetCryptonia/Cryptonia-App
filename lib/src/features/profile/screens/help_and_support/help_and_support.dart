import 'package:cryptonia/src/features/profile/widgets/about_us_action_tile.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/utils/app_constants.dart';
import 'package:cryptonia/src/shared/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpAndSupport extends StatefulWidget {
  const HelpAndSupport({super.key});

  @override
  State<HelpAndSupport> createState() => _HelpAndSupportState();
}

class _HelpAndSupportState extends State<HelpAndSupport> {
  final List<Map> _socials = [
    {
      'link': 'https://t.co/gdWLFASic7',
      'icon': 'assets/svgs/profile/whatsapp.svg'
    },
    {
      'link': 'https://x.com/getcryptonia',
      'icon': 'assets/svgs/profile/twitter.svg'
    },
    {
      'link': 'https://www.instagram.com/getcryptonia',
      'icon': 'assets/svgs/profile/instagram.svg'
    },
  ];
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
                  title: 'FAQs',
                  onTap: () async {
                    await launchUrl(
                        Uri.parse('https://getcryptonia.com/homepage#faq'));
                  },
                ),
                const Divider(),
                AboutUsActionTile(
                  title: 'Send an email',
                  onTap: () async {
                    await UiUtils.sendEmail(context,
                        recipient: 'support@getcryptonia.com',
                        subject: 'Help and Support',
                        body: '');
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.kContainerBg,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Send us a dm',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.kHintText),
                ),
                const SizedBox(),
                ..._socials.map((social) {
                  return InkWell(
                    onTap: () async {
                      await launchUrl(Uri.parse(social['link']));
                    },
                    child: SvgPicture.asset(
                      social['icon'],
                      width: 24,
                      height: 24,
                      colorFilter: const ColorFilter.mode(
                          AppColors.kHintText, BlendMode.srcIn),
                    ),
                  );
                })
              ],
            ),
          )
        ],
      ),
    );
  }
}
