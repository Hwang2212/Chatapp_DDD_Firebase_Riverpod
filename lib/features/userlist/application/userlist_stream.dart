import 'package:chatti_v2/features/firebase/firebase.dart';
import 'package:chatti_v2/global_providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../home/home.dart';

final userListStreamProvider =
    StreamProvider<List<ChatRoomTileArgs>>((ref) async* {
  final Stream<QuerySnapshot> querySnapshot = await ref
      .watch(firestoreServiceProvider)
      .getUsers(ref.watch(sharedPrefProvider).getUserUid());
  await for (var snapshot in querySnapshot) {
    List<ChatRoomTileArgs> chatroomArgsList = [];

    for (var docs in snapshot.docs) {
      String newChatroomId =
          "${docs['id']}_${ref.watch(sharedPrefProvider).getUserUid()}";
      final ChatRoomTileArgs chatroomArgs = ChatRoomTileArgs(
          userId: docs['id'],
          username: docs['username'],
          chatroomId: newChatroomId,
          lastMessage: "",
          imageUrl: docs['photoUrl'],
          timeUpdated: "");

      chatroomArgsList = [...chatroomArgsList, chatroomArgs];
      // log(chatroomArgsList[0].chatroomId.toString());
      yield chatroomArgsList;
    }
  }

  // yield querySnapshot;
});
