import 'package:flutter/material.dart';

import '../../../core.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final TextInputAction? textInputAction;
  final String? labelText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final bool isNumber;
  final String? initialValue;

  const AppTextField(
      {super.key,
      required this.onTap,
      required this.textEditingController,
      this.initialValue,
      this.textInputAction,
      this.labelText,
      this.validator,
      this.onChanged,
      this.prefixIcon,
      required this.isNumber});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // initialValue: initialValue ?? "",

      onTap: onTap,
      onChanged: onChanged,
      validator: validator,
      textInputAction: textInputAction,
      style: getMediumStyle(color: AppColors.black),

      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        labelText: labelText,
      ),
      controller: textEditingController,
      keyboardType: isNumber ? TextInputType.phone : TextInputType.text,
    );
  }
}
