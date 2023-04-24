import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'firestore_constants.dart';

class FirestoreService {
  // static Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot> getUserDetails(String userUid) async {
    return _firestore
        .collection(FirestoreConstants.pathUserCollection)
        .where(FirestoreConstants.id, isEqualTo: userUid)
        .get();
  }

  Future<void> createUser(User firebaseUser) async {
    _firestore
        .collection(FirestoreConstants.pathUserCollection)
        .doc(firebaseUser.uid)
        .set({
      'username': firebaseUser.displayName,
      'email': firebaseUser.email ?? "",
      'photoUrl': firebaseUser.photoURL,
      'id': firebaseUser.uid
    });
  }

  getUserInfo(String email) async {
    return _firestore
        .collection("users")
        .where("email", isEqualTo: email)
        .get()
        .catchError((e) {
      log(e.toString());
    });
  }

  createUserInfo() async {}

  createChatRoom(String? chatroomId, Map<String, dynamic> chatroomMap) {
    return _firestore
        .collection(FirestoreConstants.chatroomCollection)
        .doc(chatroomId)
        .set(chatroomMap)
        .catchError((error) {
      log(error);
    });
  }

  Future<Stream<QuerySnapshot>> getUserChats(String? userUid) async {
    return _firestore
        .collection(FirestoreConstants.chatroomCollection)
        .where(FirestoreConstants.usersUid, arrayContains: userUid)
        .snapshots();
  }

  Future<String> getUserImageUrl(String? userUid) async {
    return await _firestore
        .collection(FirestoreConstants.pathUserCollection)
        .doc(userUid)
        .get()
        .then((doc) {
      var document = doc.data() as Map<String, dynamic>;
      return document['photoUrl'];
    });
  }

  Future<Stream<QuerySnapshot>> getChats(String? chatroomId) async {
    return _firestore
        .collection(FirestoreConstants.chatroomCollection)
        .doc(chatroomId)
        .collection(FirestoreConstants.chatCollection)
        .orderBy(FirestoreConstants.timeUpdated)
        .snapshots();
  }

  Future<bool> checkChatroomId(String? chatroomId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> document = await _firestore
          .collection(FirestoreConstants.chatroomCollection)
          .doc(chatroomId)
          .get();
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
    // .where(FirestoreConstants.chatroomId, isEqualTo: chatroomId)
    // .snapshots();
  }

  Future<Stream<QuerySnapshot>> getUsers(String? currentUserId) async {
    return _firestore
        .collection(FirestoreConstants.pathUserCollection)
        .where(FirestoreConstants.id, isNotEqualTo: currentUserId)
        // .orderBy(FirestoreConstants.username)
        .snapshots();
  }

  Future<void> addMessage(String chatroomId, message) async {
    try {
      _firestore
          .collection(FirestoreConstants.chatroomCollection)
          .doc(chatroomId)
          .collection(FirestoreConstants.chatCollection)
          .add(message);
    } catch (e) {
      log("ERROR: Firestore - $e");
    }
  }

  Future<void> signout() async {
    // await _firestore.clearPersistence();
    await _firestore.terminate();
  }
}
