import 'package:chatti_v2/features/userlist/presentation/view/userlist_view.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AddChatroomButton extends ConsumerWidget {
  const AddChatroomButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppElevatedButton.text(
      backgroundColor: AppColors.darkBlue,
      // icon: const Icon(Icons.message),
      onPressed: () {
        context.goNamed(UserListView.routeName);
      },
      text: "Message",
    );
  }
}
