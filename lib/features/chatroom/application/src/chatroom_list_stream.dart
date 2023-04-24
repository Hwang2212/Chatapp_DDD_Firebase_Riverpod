import 'package:chatti_v2/features/firebase/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatContentStreamProvider = StreamProvider.autoDispose
    .family<List<Map<String, dynamic>>, String?>((ref, chatroomId) async* {
  final Stream<QuerySnapshot> querySnapshot =
      await ref.watch(firestoreServiceProvider).getChats(chatroomId);
  await for (var snapshot in querySnapshot) {
    List<Map<String, dynamic>> chatContentList = [];

    for (var docs in snapshot.docs) {
      chatContentList = [
        ...chatContentList,
        docs.data() as Map<String, dynamic>
      ];
      yield chatContentList;
    }
  }

  // yield querySnapshot;
});
