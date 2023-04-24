import 'package:flutter/material.dart';

import 'loading_helper.dart';

class ShowLoading extends StatelessWidget {
  final bool? noBackground;
  const ShowLoading({super.key, this.noBackground});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return noBackground!
        ? const LoadingIndicator()
        : Scaffold(
            backgroundColor: colorScheme.onPrimaryContainer.withOpacity(.75),
            body: const Align(
              alignment: Alignment.center,
              child: LoadingIndicator(),
            ),
          );
  }
}
