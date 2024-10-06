import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/theming/custom_text_styles.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final Widget? child;
  final Color? textColor;
  final Widget? leading;
  final TextStyle? textStyle;
  final Color? borderColor;
  final Color? color;
  final Color loadingColor;
  final Function()? onPressed;
  final double borderRadius;
  final double? borderWidth;
  final Gradient? gradient;
  final EdgeInsetsGeometry? padding;

  const CustomButton({
    super.key,
    this.color,
    this.child,
    this.textStyle,
    this.borderColor,
    this.borderWidth,
    this.gradient,
    this.padding,
    this.onPressed,
    this.leading,
    this.textColor,
    this.text = 'Ok',
    this.borderRadius = 8,
    this.loadingColor = Colors.white,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  //bool loading = false;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed == null
          ? null
          : () async {
              await widget.onPressed!();
            },
      style: ElevatedButton.styleFrom(
        padding: widget.padding,
        backgroundColor: widget.color,
        shadowColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color:
                  widget.borderColor ?? (widget.color ?? AppColors.kPrimary)),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
      ),
      child: widget.child ??
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.leading != null)
                Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: widget.leading),
              Text(
                widget.text,
                style: widget.textStyle ??
                    TextStylesTheme.elevatedButton
                        .copyWith(color: Colors.white),
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
    );
  }
}
