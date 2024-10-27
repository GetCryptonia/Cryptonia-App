import 'package:cryptonia/src/core/local/page_navigation.dart';
import 'package:cryptonia/src/features/transaction/screens/submitted_review.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/utils/app_constants.dart';
import 'package:cryptonia/src/shared/widgets/custom_button.dart';
import 'package:cryptonia/src/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RateExperience extends StatefulWidget {
  const RateExperience({super.key});

  @override
  State<RateExperience> createState() => _RateExperienceState();
}

class _RateExperienceState extends State<RateExperience> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(20),
          child: InkWell(
            onTap: () => PageNavigation.popPage(context),
            child: SvgPicture.asset(
              'assets/svgs/onboarding/close.svg',
              width: 12,
              height: 12,
            ),
          ),
        ),
        title: const Text('Review'),
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
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.kContainerBg,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Rate your experience',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 24),
                        //a row of five outline stars with a space of 8 between each star and hint color
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            5,
                            (index) => const Padding(
                              padding: EdgeInsets.only(right: 8),
                              child:
                                  Icon(Icons.star, color: AppColors.kPrimary),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        CustomRoundedTextField(
                          hint: 'Tell us how you feel.',
                          maxLines: 5,
                          fillColor: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            CustomButton(
              onPressed: () =>
                  PageNavigation.pushPage(context, const SubmittedReview()),
              text: 'Submit',
            )
          ],
        ),
      ),
    );
  }
}
