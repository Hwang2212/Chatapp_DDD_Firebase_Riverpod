import 'package:flutter/material.dart';

import '../../../core.dart';

class AppOutlineButton extends StatelessWidget {
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final Color? borderColor;
  final Color? textColor;
  final Size? fixedSize;
  final VoidCallback? onPressed;
  final Widget? child;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final Color? shadowColor;
  final OutlinedBorder? shape;
  final bool needClipOval;
  final TextAlign? textAlign;
  final double? borderWidth;

  const AppOutlineButton(
      {required this.onPressed,
      this.backgroundColor,
      this.borderRadius,
      this.textColor = AppColors.darkBlue,
      super.key,
      this.textAlign,
      this.fixedSize,
      this.shape,
      this.padding,
      this.needClipOval = false,
      this.child,
      this.shadowColor,
      this.borderWidth,
      this.textStyle,
      this.borderColor});

  factory AppOutlineButton.text({
    required VoidCallback? onPressed,
    Color? backgroundColor,
    Color? borderColor,
    Color? textColor,
    Size? fixedSize,
    BorderRadius? borderRadius,
    EdgeInsets? padding,
    TextAlign? textAlign,
    double? borderWidth,
    required String text,
  }) = _AppOutlineButtonWithText;

  factory AppOutlineButton.circular({
    required VoidCallback? onPressed,
    Color? backgroundColor,
    Color? textColor,
    required double radius,
    EdgeInsets? padding,
    required Widget child,
  }) = _AppOutlineButtonWithCircular;

  factory AppOutlineButton.icon(
      {required VoidCallback? onPressed,
      BorderRadius? borderRadius,
      Color? backgroundColor,
      Color? textColor,
      TextStyle? textStyle,
      double? borderWidth,
      required String text,
      Size? fixedSize,
      required Widget icon,
      EdgeInsets? padding}) = _AppOutlineButtonWithIcon;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Widget button = OutlinedButtonTheme(
      data: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              disabledForegroundColor: colorScheme.onBackground,
              disabledBackgroundColor: colorScheme.shadow,
              shadowColor: shadowColor ?? Colors.transparent,
              backgroundColor: backgroundColor ?? colorScheme.onBackground,
              textStyle: textStyle,
              side: BorderSide(
                width: borderWidth ?? 1,
                color: borderColor ?? Colors.transparent,
              ),
              shape: shape ??
                  RoundedRectangleBorder(
                      side: const BorderSide(color: AppColors.black, width: 10),
                      borderRadius: borderRadius ?? BorderRadius.circular(10)),
              fixedSize: fixedSize ?? const Size(AppSize.s110, AppSize.s40),
              foregroundColor: textColor,
              padding: padding)),
      child: OutlinedButton(
          clipBehavior: Clip.antiAlias, onPressed: onPressed, child: child!),
    );

    if (needClipOval) {
      return ClipOval(
        child: button,
      );
    }

    return button;
  }
}

class _AppOutlineButtonWithText extends AppOutlineButton {
  _AppOutlineButtonWithText(
      {super.onPressed,
      required String text,
      super.backgroundColor,
      super.borderColor,
      super.borderRadius,
      super.textColor,
      super.borderWidth,
      super.textAlign,
      super.padding,
      super.fixedSize})
      : super(
            child: _AppOutlineButtonWithTextChild(
          text: text,
          textAlign: textAlign,
          textColor: textColor,
        ));
}

class _AppOutlineButtonWithTextChild extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final Color? textColor;
  const _AppOutlineButtonWithTextChild(
      {required this.text, this.textAlign, this.textColor});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style:
          getBoldStyle(fontSize: 13.0, color: textColor ?? AppColors.darkBlue),
    );
  }
}

class _AppOutlineButtonWithIcon extends AppOutlineButton {
  _AppOutlineButtonWithIcon(
      {super.onPressed,
      required String text,
      super.borderRadius,
      super.backgroundColor,
      super.textColor,
      super.borderWidth,
      super.textStyle,
      super.fixedSize,
      super.padding,
      required Widget icon})
      : super(
            child: _AppOutlineButtonWithIconChild(
          text: text,
          icon: icon,
          textStyle: textStyle,
        ));
}

class _AppOutlineButtonWithIconChild extends StatelessWidget {
  final String text;
  final Widget icon;
  final TextStyle? textStyle;
  const _AppOutlineButtonWithIconChild(
      {required this.text, required this.icon, this.textStyle});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        const SizedBox(
          width: 10,
        ),
        Text(
          text,
          style: textStyle,
        ),
      ],
    );
  }
}

class _AppOutlineButtonWithCircular extends AppOutlineButton {
  _AppOutlineButtonWithCircular(
      {super.onPressed,
      super.backgroundColor,
      super.textColor,
      required double radius,
      super.padding = EdgeInsets.zero,
      super.child})
      : super(
          needClipOval: true,
          shape: const CircleBorder(side: BorderSide()),
          fixedSize: Size(radius * 2, radius * 2),
        );
}
