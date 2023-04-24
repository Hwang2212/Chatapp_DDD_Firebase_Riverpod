import 'package:flutter/material.dart';

import '../../../core.dart';

class AppElevatedButton extends StatelessWidget {
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final Color? textColor;
  final Size? fixedSize;
  final VoidCallback? onPressed;
  final Widget? child;
  final EdgeInsets? padding;
  final Color? shadowColor;
  final OutlinedBorder? shape;
  final bool needClipOval;
  final TextAlign? textAlign;
  final BorderSide? side;
  final Color? borderColor;
  final double? borderWidth;
  final double? elevation;
  final TextStyle? textStyle;

  const AppElevatedButton(
      {required this.onPressed,
      this.backgroundColor,
      this.borderRadius,
      this.textColor = AppColors.white,
      super.key,
      this.textAlign,
      this.fixedSize,
      this.shape,
      this.padding,
      this.needClipOval = false,
      this.child,
      this.shadowColor,
      this.side,
      this.borderColor,
      this.elevation,
      this.borderWidth,
      this.textStyle});

  factory AppElevatedButton.text({
    required VoidCallback? onPressed,
    Color? backgroundColor,
    Color? textColor,
    Size? fixedSize,
    BorderRadius? borderRadius,
    EdgeInsets? padding,
    TextAlign? textAlign,
    required String text,
    BorderSide? side,
  }) = _AppElevatedButtonWithText;

  factory AppElevatedButton.circular(
      {required VoidCallback? onPressed,
      Color? backgroundColor,
      Color? textColor,
      required double radius,
      EdgeInsets? padding,
      required Widget child,
      Color? borderColor,
      double? borderWidth}) = _AppElevatedButtonWithCircular;

  factory AppElevatedButton.icon(
      {required VoidCallback? onPressed,
      BorderRadius? borderRadius,
      Color? backgroundColor,
      Color? textColor,
      required String text,
      Size? fixedSize,
      required Widget icon,
      BorderSide? side,
      EdgeInsets? padding}) = _AppElevatedButtonWithIcon;

  factory AppElevatedButton.trailingIcon(
      {required VoidCallback? onPressed,
      BorderRadius? borderRadius,
      Color? backgroundColor,
      Color? textColor,
      required String text,
      Size? fixedSize,
      required Widget icon,
      BorderSide? side,
      EdgeInsets? padding,
      TextStyle? textStyle}) = _AppElevatedButtonWithTrailingIcon;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Widget button = ElevatedButtonTheme(
      data: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              // shadowColor: shadowColor ?? Colors.transparent,
              backgroundColor: backgroundColor ?? AppColors.white,
              shape: shape ??
                  RoundedRectangleBorder(
                      side: side ?? const BorderSide(color: Colors.transparent),
                      borderRadius: borderRadius ?? BorderRadius.circular(10)),
              fixedSize: fixedSize ?? const Size(AppSize.s110, AppSize.s40),
              foregroundColor: textColor ?? AppColors.black,
              elevation: elevation,
              padding: padding)),
      child: ElevatedButton(
          clipBehavior: Clip.antiAlias, onPressed: onPressed, child: child),
    );

    if (needClipOval) {
      return ClipOval(
        child: button,
      );
    }

    return button;
  }
}

class _AppElevatedButtonWithText extends AppElevatedButton {
  _AppElevatedButtonWithText({
    super.onPressed,
    required String text,
    super.backgroundColor,
    super.borderRadius,
    super.textColor,
    super.textAlign,
    super.padding,
    super.fixedSize,
    super.side,
  }) : super(
            child: _AppElevatedButtonWithTextChild(
          text: text,
          textAlign: textAlign,
          textColor: textColor,
        ));
}

class _AppElevatedButtonWithTextChild extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final Color? textColor;
  const _AppElevatedButtonWithTextChild(
      {required this.text, this.textAlign, this.textColor});
  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: textAlign,
        style: getBoldStyle(fontSize: 16, color: textColor!));
  }
}

class _AppElevatedButtonWithIcon extends AppElevatedButton {
  _AppElevatedButtonWithIcon(
      {super.onPressed,
      required String text,
      super.borderRadius,
      super.backgroundColor,
      super.textColor,
      super.fixedSize,
      super.padding,
      required Widget icon,
      super.side})
      : super(
            child: _AppElevatedButtonWithIconChild(
          text: text,
          icon: icon,
          side: side,
          textColor: textColor,
        ));
}

class _AppElevatedButtonWithIconChild extends StatelessWidget {
  final String text;
  final Widget icon;
  final BorderSide? side;
  final Color? textColor;
  const _AppElevatedButtonWithIconChild(
      {required this.text, required this.icon, this.side, this.textColor});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        icon,
        // Spacer(),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: Text(text,
              style: getBoldStyle(
                  fontSize: 13.0, color: textColor ?? AppColors.black)),
        )
      ],
    );
  }
}

class _AppElevatedButtonWithCircular extends AppElevatedButton {
  _AppElevatedButtonWithCircular(
      {super.onPressed,
      super.backgroundColor,
      super.textColor,
      required double radius,
      super.padding = EdgeInsets.zero,
      super.borderColor,
      super.borderWidth,
      super.child})
      : super(
          needClipOval: true,
          shape: CircleBorder(
              side: BorderSide(
                  color: borderColor ?? AppColors.black,
                  width: borderWidth ?? 1)),
          fixedSize: Size(radius * 2, radius * 2),
        );
}

class _AppElevatedButtonWithTrailingIcon extends AppElevatedButton {
  _AppElevatedButtonWithTrailingIcon(
      {super.onPressed,
      required String text,
      super.borderRadius,
      super.backgroundColor,
      super.textColor,
      super.fixedSize,
      super.padding,
      super.side,
      super.textStyle,
      required Widget icon})
      : super(
            child: _AppElevatedButtonWithTrailingIconChild(
                text: text, icon: icon, side: side, textStyle: textStyle));
}

class _AppElevatedButtonWithTrailingIconChild extends StatelessWidget {
  final String text;
  final Widget icon;
  final BorderSide? side;
  final TextStyle? textStyle;

  const _AppElevatedButtonWithTrailingIconChild(
      {required this.text, required this.icon, this.side, this.textStyle});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text, style: textStyle),
        icon,
      ],
    );
  }
}
