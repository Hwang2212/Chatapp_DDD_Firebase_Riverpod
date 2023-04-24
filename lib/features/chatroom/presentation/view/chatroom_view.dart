import 'package:flutter/foundation.dart' as foundation;
import 'package:chatti_v2/features/chatroom/application/src/chatroom_list_stream.dart';
import 'package:chatti_v2/features/firebase/firebase.dart';
import 'package:chatti_v2/global_providers.dart';
import 'package:core/core.dart';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../chatroom.dart';

class ChatroomView extends ConsumerStatefulWidget {
  static String get routeName => 'chatroom';
  static String get routeLocation => routeName;
  final String? chatroomId;
  final String? messageTo;

  const ChatroomView({super.key, this.chatroomId, this.messageTo});

  @override
  ChatroomViewState createState() => ChatroomViewState();
}

class ChatroomViewState extends ConsumerState<ChatroomView> {
  final TextEditingController _messageTEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: mainAppBar(),
      body: Stack(
        children: [
          const BackgroundWidget(),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: buildMainContent(),
          ),
        ],
      ),
      // bottomNavigationBar: AddMessageField(
      //   addMessageTEC: _messageTEC,
      //   onTapButton: () async {
      //     String? fromUser = ref.watch(sharedPrefProvider).getUserUid();
      //     String toUser = widget.chatroomId!
      //         .split("_")
      //         .firstWhere((element) => element != fromUser)
      //         .toString();
      //     // log(toUser.toString());
      //     addMessage(
      //         message: _messageTEC.text, sendBy: fromUser!, sendTo: toUser);
      //   },
      // ),
    );
  }

  void addMessage(
      {String? message, required String sendBy, required String sendTo}) async {
    Map<String, dynamic> messageMap = {
      "from_user": sendBy,
      "to_user": sendTo,
      "message": message,
      "time_updated": (DateTime.now().add(const Duration(hours: 14))).toString()
    };
    if (message == null || message == "") {
      return;
    }

    await ref
        .watch(firestoreServiceProvider)
        .addMessage(widget.chatroomId!, messageMap);
    _messageTEC.clear();
  }

  AppBar mainAppBar() {
    return AppBar(
      title: Text(widget.messageTo ?? ""),
      leading: AppBackButton(
        onPressed: () {
          context.pop();
        },
      ),
    );
  }

  Widget buildMainContent() {
    return Column(
      children: [
        buildChatList(),
        AddMessageField(
          addMessageTEC: _messageTEC,
          onTapButton: () async {
            ref.watch(emojiShowingProvider.notifier).update((state) => false);
            String? fromUser = ref.watch(sharedPrefProvider).getUserUid();
            String toUser = widget.chatroomId!
                .split("_")
                .firstWhere((element) => element != fromUser)
                .toString();
            // log(toUser.toString());
            addMessage(
                message: _messageTEC.text, sendBy: fromUser!, sendTo: toUser);
          },
        ),
        Offstage(
          offstage: !ref.watch(emojiShowingProvider),
          child: SizedBox(
            height: 200,
            child: EmojiPicker(
              onEmojiSelected: (category, emoji) {
                // Do something when emoji is tapped (optional)
              },
              onBackspacePressed: () {},
              textEditingController: _messageTEC,
              config: Config(
                columns: 7,
                emojiSizeMax: 32 *
                    (foundation.defaultTargetPlatform == TargetPlatform.iOS
                        ? 1.30
                        : 1.0),
                verticalSpacing: 0,
                horizontalSpacing: 0,
                gridPadding: EdgeInsets.zero,
                initCategory: Category.RECENT,
                bgColor: Color(0xFFF2F2F2),
                indicatorColor: Colors.blue,
                iconColor: Colors.grey,
                iconColorSelected: Colors.blue,
                backspaceColor: Colors.blue,
                skinToneDialogBgColor: Colors.white,
                skinToneIndicatorColor: Colors.grey,
                enableSkinTones: true,
                showRecentsTab: true,
                recentsLimit: 28,
                noRecents: const Text(
                  'No Recents',
                  style: TextStyle(fontSize: 20, color: Colors.black26),
                  textAlign: TextAlign.center,
                ), // Needs to be const Widget
                loadingIndicator:
                    const SizedBox.shrink(), // Needs to be const Widget
                tabIndicatorAnimDuration: kTabScrollDuration,
                categoryIcons: const CategoryIcons(),
                buttonMode: ButtonMode.MATERIAL,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget buildChatList() {
    final chatcontent =
        ref.watch(chatContentStreamProvider(widget.chatroomId!));
    return Container(
      padding: const EdgeInsets.only(top: 20),
      height: ScreenUtils.idealScreenHeight,
      child: chatcontent.when(
        data: (list) {
          return ListView.builder(
              shrinkWrap: true,
              padding: AppPadding.contentPadding,
              itemCount: list.length,
              itemBuilder: ((context, index) {
                Map<String, dynamic> data = list[index];

                return MessageTile(messageData: data);
              }));
        },
        error: (error, stackTrace) {
          return Center(
            child: Text(error.toString() + stackTrace.toString()),
          );
        },
        loading: () {
          return const SizedBox();
        },
      ),
    );
  }
}

class MessageTile extends ConsumerWidget {
  final Map<String, dynamic> messageData;
  // final bool senderIsMe;
  const MessageTile({super.key, required this.messageData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool senderIsMe;
    if (messageData['from_user'] ==
        ref.watch(sharedPrefProvider).getUserUid()) {
      senderIsMe = true;
    } else {
      senderIsMe = false;
    }
    return Container(
      padding: EdgeInsets.only(
          bottom: 8, left: senderIsMe ? 0 : 24, right: senderIsMe ? 24 : 0),
      alignment: senderIsMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Card(
        color: senderIsMe ? AppColors.white : AppColors.aquaBlue,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s20)),
        child: Container(
            margin: senderIsMe
                ? const EdgeInsets.only(left: 20)
                : const EdgeInsets.only(right: 20),
            padding: const EdgeInsets.all(AppPadding.p10),
            child: Text(
              messageData['message'],
              textAlign: senderIsMe ? TextAlign.end : TextAlign.start,
            )),
      ),
    );
  }
}
