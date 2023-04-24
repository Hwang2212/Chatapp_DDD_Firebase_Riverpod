import 'dart:developer';

import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final emojiShowingProvider = StateProvider<bool>((ref) {
  return false;
});

class AddMessageField extends ConsumerStatefulWidget {
  final TextEditingController addMessageTEC;
  final VoidCallback onTapButton;
  const AddMessageField(
      {super.key, required this.addMessageTEC, required this.onTapButton});

  @override
  AddMessageFieldState createState() => AddMessageFieldState();
}

class AddMessageFieldState extends ConsumerState<AddMessageField> {
  TextEditingController get addMessageTEC => widget.addMessageTEC;
  bool get emojiShowing => ref.watch(emojiShowingProvider);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  ref
                      .watch(emojiShowingProvider.notifier)
                      .update((state) => !state);
                },
                icon: const Icon(Icons.emoji_emotions)),
            Expanded(
              child: AppTextFormField(
                textEditingController: addMessageTEC,
                onTap: () {
                  ref
                      .watch(emojiShowingProvider.notifier)
                      .update((state) => false);
                },
              ),
            ),
            AppIconButton(
                icon: const Icon(Icons.more_horiz_rounded), onPressed: () {}),
            AppIconButton(
                icon: const Icon(Icons.send), onPressed: widget.onTapButton)
          ],
        ),
      ),
    );
  }
}
