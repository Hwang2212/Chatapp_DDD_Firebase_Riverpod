import 'package:chatti_v2/features/home/presentation/view/home_view.dart';
import 'package:chatti_v2/features/login/login.dart';
import 'package:chatti_v2/features/onboarding/presentation/view/onboarding_view.dart';
import 'package:chatti_v2/features/userlist/presentation/view/userlist_view.dart';
import 'package:chatti_v2/global_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'features/chatroom/chatroom.dart';
import 'features/splash/splash.dart';

final _key = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  // final authState = ref.watch(authNotifierProvider);

  return GoRouter(
    navigatorKey: _key,
    debugLogDiagnostics: true,
    initialLocation: SplashView.routeLocation,
    routes: [
      GoRoute(
        path: SplashView.routeLocation,
        name: SplashView.routeName,
        builder: (context, state) {
          return const SplashView();
        },
      ),
      GoRoute(
        path: OnboardingView.routeLocation,
        name: OnboardingView.routeName,
        builder: (context, state) {
          return const OnboardingView();
        },
      ),
      GoRoute(
        path: LoginView.routeLocation,
        name: LoginView.routeName,
        builder: (context, state) {
          return const LoginView();
        },
      ),
      GoRoute(
          path: HomeView.routeLocation,
          name: HomeView.routeName,
          builder: (context, state) {
            return const HomeView();
          },
          routes: [
            GoRoute(
              name: UserListView.routeName,
              path: UserListView.routeLocation,
              builder: (context, state) => const UserListView(),
            ),
            GoRoute(
              name: ChatroomView.routeName,
              path: ChatroomView.routeLocation,
              builder: (context, state) => ChatroomView(
                chatroomId: state.queryParams['chatroomId'],
                messageTo: state.queryParams['messageTo'],
              ),
            ),
          ]),
      // GoRoute(
      //   path: LoginPage.routeLocation,
      //   name: LoginPage.routeName,
      //   builder: (context, state) {
      //     return const LoginPage();
      //   },
      // ),
    ],
    redirect: (context, state) {
      final isAuth = ref.watch(sharedPrefProvider).getHasLoggedIn();

      final isSplash = state.location == SplashView.routeLocation;
      if (isSplash) {
        return isAuth ? HomeView.routeLocation : SplashView.routeLocation;
      }

      // final isLoggingIn = state.location == LoginView.routeLocation;
      // if (isLoggingIn) return isAuth ? HomeView.routeLocation : null;

      // return isAuth ? null : SplashView.routeLocation;
    },
  );
});
