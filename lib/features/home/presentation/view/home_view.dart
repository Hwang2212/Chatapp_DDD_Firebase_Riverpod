import 'dart:developer';

import 'package:chatti_v2/features/firebase/firebase.dart';
import 'package:chatti_v2/features/home/application/src/chatroom_list_stream.dart';
import 'package:chatti_v2/features/onboarding/onboarding.dart';
import 'package:chatti_v2/features/splash/splash.dart';
import 'package:chatti_v2/global_providers.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../home.dart';

class HomeView extends ConsumerStatefulWidget {
  static String get routeName => 'home';
  static String get routeLocation => '/$routeName';

  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        width: 200,
        child: SizedBox(
          height: double.infinity,
          // width: 250,
          child: ListView(
            children: [
              ListTile(
                title: const Text("Logout"),
                onTap: () async {
                  await ref.watch(firebaseAuthProvider).signOut();
                  await ref.watch(sharedPrefProvider).clear();
                  await ref.watch(firestoreServiceProvider).signout();
                  if (!mounted) {
                    return;
                  }
                  context.go(OnboardingView.routeLocation);
                },
              )
            ],
          ),
        ),
      ),
      appBar: mainAppBar(),
      body: Stack(children: [
        const BackgroundWidget(),
        buildMainContent(),
      ]),
      floatingActionButton: const AddChatroomButton(),
    );
  }

  AppBar mainAppBar() {
    return AppBar(
      backgroundColor: AppColors.aquaBlue,
      title: const Text("Chatti!"),
      // leading: InkWell(
      //   onTap: () {},
      //   child: const Icon(
      //     Icons.list,
      //     color: AppColors.black,
      //   ),
      // ),
    );
  }

  Widget buildMainContent() {
    // return state.when(authenticateCancel: )
    return ListView(
      children: [
        // Padding(
        //   padding: const EdgeInsets.only(top: 10.0, left: 20),
        //   child: Text(
        //     "Welcome ${ref.watch(sharedPrefProvider).getUsername() ?? "User"}",
        //     style: getBoldStyle(fontSize: FontSize.s24),
        //   ),
        // ),
        buildChatList(),
        // const SizedBox(
        //   height: AppSize.s20,
        // ),
      ],
    );
  }

  Widget buildChatList() {
    final chatroomStream = ref.watch(chatListStreamProvider);
    return SizedBox(
        width: double.infinity,
        height: ScreenUtils.idealScreenHeight,
        child: chatroomStream.when(data: (list) {
          return ListView.builder(
              shrinkWrap: true,
              padding: AppPadding.contentPadding,
              itemCount: list.length,
              itemBuilder: ((context, index) {
                return ChatRoomTile(chatRoomTileArgs: list[index]);
              }));
        }, error: (error, stackTrace) {
          log(error.toString(), stackTrace: stackTrace);
          return Center(
            child: Text(error.toString() + stackTrace.toString()),
          );
        }, loading: () {
          return const Center(child: LoadingIndicator());
        }));
  }
}
