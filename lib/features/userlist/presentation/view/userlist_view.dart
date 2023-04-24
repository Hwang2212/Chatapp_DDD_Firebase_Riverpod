import 'dart:developer';

import 'package:chatti_v2/features/chatroom/application/src/chatroom_list_stream.dart';
import 'package:chatti_v2/features/firebase/firebase.dart';
import 'package:chatti_v2/features/userlist/application/userlist_stream.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../global_providers.dart';
import '../../../chatroom/chatroom.dart';
import '../../../home/home.dart';

class UserListView extends ConsumerStatefulWidget {
  static String get routeName => 'userlist';
  static String get routeLocation => routeName;

  const UserListView({super.key});

  @override
  UserListViewState createState() => UserListViewState();
}

class UserListViewState extends ConsumerState<UserListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(),
      body: Stack(children: [
        const BackgroundWidget(),
        buildMainContent(),
      ]),
      // floatingActionButton: AddC,
    );
  }

  AppBar mainAppBar() {
    return AppBar(
      title: const Text("Users"),
      leading: AppBackButton(
        onPressed: () {
          context.pop();
        },
      ),
    );
  }

  Widget buildMainContent() {
    return ListView(
      children: [
        buildChatList(),
        const SizedBox(
          height: AppSize.s20,
        ),
      ],
    );
  }

  Widget buildChatList() {
    final userStream = ref.watch(userListStreamProvider);
    return SizedBox(
        width: double.infinity,
        height: ScreenUtils.idealScreenHeight,
        child: userStream.when(data: (list) {
          log(list.toString());
          return ListView.builder(
              shrinkWrap: true,
              padding: AppPadding.contentPadding,
              itemCount: list.length,
              itemBuilder: ((context, index) {
                return ChatRoomTile(
                  chatRoomTileArgs: ChatRoomTileArgs(
                      username: list[index].username,
                      onTap: () async {
                        // log(newChatroomId);
                        context.goNamed(ChatroomView.routeLocation,
                            queryParams: {
                              'chatroomId': list[index].chatroomId,
                              'messageTo': list[index].username
                            });
                        // bool isNewChat = await ref
                        //     .watch(firestoreServiceProvider)
                        //     .checkChatroomId(list[index].chatroomId);
                        // log(isNewChat.toString());
                        Map<String, dynamic> chatroomMap = {
                          FirestoreConstants.pathUserCollection: [
                            list[index].username,
                            ref.watch(sharedPrefProvider).getUsername()
                          ],
                          FirestoreConstants.usersUid: [
                            list[index].userId,
                            ref.watch(sharedPrefProvider).getUserUid()
                          ],
                          FirestoreConstants.chatroomId: list[index].chatroomId,
                          FirestoreConstants.timeUpdated: DateTime.now(),
                          "last_message": ref
                              .read(chatContentStreamProvider(
                                  list[index].chatroomId))
                              .value
                              ?.last
                        };

                        ref.watch(firestoreServiceProvider).createChatRoom(
                            list[index].chatroomId, chatroomMap);
                      },
                      lastMessage: "",
                      imageUrl: list[index].imageUrl,
                      timeUpdated: ""),
                );
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
