import 'package:flutter/cupertino.dart';

class ContainerBg extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  const ContainerBg({
    super.key,
    this.width,
    this.height,
    this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/onboarding/bg_pattern.png'),
            fit: BoxFit.cover),
      ),
      child: child,
    );
  }
}
