import 'package:flutter/material.dart';

class AppBackButton extends StatelessWidget {
  final VoidCallback onPressed;
  const AppBackButton({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_rounded),
      onPressed: onPressed,
    );
  }
}
