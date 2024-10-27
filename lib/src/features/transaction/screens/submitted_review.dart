import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/utils/app_constants.dart';
import 'package:cryptonia/src/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SubmittedReview extends StatefulWidget {
  const SubmittedReview({super.key});

  @override
  State<SubmittedReview> createState() => _SubmittedReviewState();
}

class _SubmittedReviewState extends State<SubmittedReview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Order Completed'),
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
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: AppColors.kContainerBg,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                            'assets/svgs/history/checkbox-circle-fill.svg',
                            width: 56,
                            height: 56),
                        const SizedBox(height: 16),
                        Text(
                          'Thank you for your\nreview!',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            CustomButton(
              text: 'Submit',
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
