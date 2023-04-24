import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Platform.isIOS
        ? CupertinoActivityIndicator(
            color: colorScheme.secondary,
          )
        : CircularProgressIndicator(
            color: colorScheme.secondary,
          );
  }
}
