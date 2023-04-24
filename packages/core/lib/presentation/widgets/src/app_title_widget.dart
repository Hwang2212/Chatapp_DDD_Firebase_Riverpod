import 'package:flutter/material.dart';

import '../../../core.dart';

class AppTitleWidget extends StatelessWidget {
  final String title;
  final String? description;
  const AppTitleWidget({super.key, required this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppPadding.p20, left: 0, right: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Text(title)],
      ),
    );
  }
}
