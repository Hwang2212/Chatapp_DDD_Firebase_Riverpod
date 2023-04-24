import 'package:chatti_v2/features/chatroom/chatroom.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatRoomTileArgs {
  final String username;
  final String? lastMessage;
  final String? imageUrl;
  final String? timeUpdated;
  final String? chatroomId;
  final String? userId;
  final String? messageTo;
  final VoidCallback? onTap;

  ChatRoomTileArgs(
      {this.onTap,
      this.userId,
      this.chatroomId,
      this.messageTo,
      this.imageUrl,
      required this.username,
      this.lastMessage,
      this.timeUpdated});
}

class ChatRoomTile extends StatelessWidget {
  final ChatRoomTileArgs chatRoomTileArgs;
  const ChatRoomTile({super.key, required this.chatRoomTileArgs});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: chatRoomTileArgs.onTap ??
          () {
            context.goNamed(ChatroomView.routeLocation, queryParams: {
              'chatroomId': chatRoomTileArgs.chatroomId,
              'messageTo': chatRoomTileArgs.messageTo
            });
          },
      child: Card(
        color: AppColors.white.withOpacity(0.8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: AppPadding.p15, horizontal: AppPadding.p10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                child: chatRoomTileArgs.imageUrl == null
                    ? const Icon(Icons.people)
                    : ClipOval(
                        child: AppImageWidget(
                            isProfile: true,
                            imageUrl: chatRoomTileArgs.imageUrl),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: AppPadding.p40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chatRoomTileArgs.username,
                      style: getExtraBoldStyle(fontSize: FontSize.s22),
                    ),
                    Text(
                      chatRoomTileArgs.lastMessage ?? " - ",
                      style: const TextStyle(
                          fontSize: FontSize.s12, color: AppColors.greYer),
                    )
                  ],
                ),
              ),
              // Padding(
              //     padding: const EdgeInsets.only(left: AppPadding.p60),
              //     child: Text(
              //       chatRoomTileArgs.timeUpdated!.split("(")[0],
              //       style: const TextStyle(
              //           fontSize: FontSize.s12, color: AppColors.greYer),
              //     ))
            ],
          ),
        ),
      ),
    );
  }
}
