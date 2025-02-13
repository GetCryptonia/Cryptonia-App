import 'package:cryptonia/src/core/local/page_navigation.dart';
import 'package:cryptonia/src/features/auth/providers/auth_provider.dart';
import 'package:cryptonia/src/features/auth/screens/onboarding.dart';
import 'package:cryptonia/src/shared/widgets/container_bg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AuthProvider>().fetchLoginDetails();
    Future.delayed(const Duration(seconds: 3), () {
      PageNavigation.pushPage(context, const Onboarding());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ContainerBg(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Image.asset('assets/images/onboarding/logo.png',
                fit: BoxFit.cover, height: 150),
          ),
        ),
      ),
    );
  }
}
