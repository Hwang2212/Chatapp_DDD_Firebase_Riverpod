import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onPressed;
  const AppIconButton({required this.icon, Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(icon: icon, onPressed: onPressed);
  }
}
