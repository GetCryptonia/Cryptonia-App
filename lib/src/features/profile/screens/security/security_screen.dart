import 'package:cryptonia/src/features/auth/providers/auth_provider.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  bool _isBiometricsEnabled = false;

  void checkBiometrics() async {
    //check if user can use biometrics
    final biometricRes = await context.read<AuthProvider>().canUseBiometrics();

    if (biometricRes == false) {
      setState(() {
        _isBiometricsEnabled = false;
      });
      return;
    }

    //check if there
    await context.read<AuthProvider>().fetchLoginDetails();
    setState(() {
      _isBiometricsEnabled = context.read<AuthProvider>().loginDetails != null;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkBiometrics();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Security'),
        backgroundColor: AppColors.kContainerBg,
      ),
      body: ListView(
        padding: AppConstants.kScaffoldPadding,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.kContainerBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Login with biometrics'),
                Switch(
                  value: _isBiometricsEnabled,
                  thumbColor: const WidgetStatePropertyAll<Color>(Colors.white),
                  inactiveTrackColor: Theme.of(context).scaffoldBackgroundColor,
                  trackOutlineColor: WidgetStatePropertyAll<Color>(
                      _isBiometricsEnabled
                          ? AppColors.kPrimary
                          : Theme.of(context).scaffoldBackgroundColor),
                  onChanged: (bool value) {
                    setState(() {
                      _isBiometricsEnabled = value;
                    });
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
