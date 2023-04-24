import 'dart:developer';

import 'package:chatti_v2/features/auth/application/auth_provider.dart';
import 'package:chatti_v2/features/auth/application/auth_state.dart';
import 'package:chatti_v2/global_providers.dart';
import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../../../../onboarding/onboarding.dart';

class SplashView extends ConsumerStatefulWidget {
  static String get routeName => 'splash';
  static String get routeLocation => '/$routeName';

  const SplashView({super.key});

  @override
  SplashViewState createState() => SplashViewState();
}

class SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    super.initState();
    // AuthState authState =
    //     ref.watch(authNotifierProvider.select((state) => state));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 3), pushToOnboardingScreen);
    });
    // authState.when(
    //     initializing: () {

    //     },
    //     authenticated: (user) {
    //       WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //         Future.delayed(const Duration(seconds: 3), pushToOnboardingScreen);
    //       });
    //     },
    //     loading: () {},
    //     authenticateCancel: () {},
    //     error: (error, trace) {});
  }

  void pushToOnboardingScreen() {
    context.go(OnboardingView.routeLocation);
  }

  // void pushToHome() {
  //   context.go(HomeView.routeName);
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ScreenUtils.setScreenSize(size);

    return Scaffold(
      body: Stack(children: [
        const BackgroundWidget(),
        Center(
          child: Text(
            "Chatti",
            style: getBoldStyle(fontSize: FontSize.s24),
          ),
        ),
      ]),
    );
  }
}
