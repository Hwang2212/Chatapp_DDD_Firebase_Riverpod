import 'dart:developer';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'global_providers.dart';
import 'router.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final initialize = ref.watch(firebaseinitializerProvider);

    return initialize.when(
      data: (data) {
        return MaterialApp.router(
          routeInformationParser: router.routeInformationParser,
          routerDelegate: router.routerDelegate,
          routeInformationProvider: router.routeInformationProvider,
          theme: AppThemeData.lightThemeData,
        );
      },
      loading: () {
        return const Center(child: LoadingIndicator());
      },
      error: (error, stackTrace) {
        log(error.toString(), stackTrace: stackTrace);
        return Text(error.toString() + stackTrace.toString());
      },
    );
  }
}
