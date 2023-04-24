import 'dart:developer';

import 'package:chatti_v2/features/firebase/firebase.dart';
import 'package:chatti_v2/global_providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../home.dart';

final chatListStreamProvider =
    StreamProvider<List<ChatRoomTileArgs>>((ref) async* {
  final Stream<QuerySnapshot> querySnapshot = await ref
      .watch(firestoreServiceProvider)
      .getUserChats(ref.watch(sharedPrefProvider).getUserUid());
  await for (var snapshot in querySnapshot) {
    List<ChatRoomTileArgs> chatroomArgsList = [];

    for (var docs in snapshot.docs) {
      String name;
      if (docs['users'].first == ref.watch(sharedPrefProvider).getUsername()) {
        name = docs['users'].last;
      } else {
        name = docs['users'].first;
      }

      String imageUrl;
      if (docs['users_uid'].first ==
          ref.watch(sharedPrefProvider).getUserUid()) {
        imageUrl = docs['users_uid'].last;
      } else {
        imageUrl = docs['users_uid'].first;
      }
      String userImageUrl =
          await ref.watch(firestoreServiceProvider).getUserImageUrl(imageUrl);

      final ChatRoomTileArgs chatroomArgs = ChatRoomTileArgs(
        username: name,
        chatroomId: docs['chatroom_id'],
        imageUrl: userImageUrl,
        messageTo: name,

        // lastMessage: docs['last_message'],
        // timeUpdated: docs['time_updated'].toString()
      );

      chatroomArgsList = [...chatroomArgsList, chatroomArgs];
      log(chatroomArgsList[0].chatroomId.toString());
      yield chatroomArgsList;
    }
  }

  // yield querySnapshot;
});
