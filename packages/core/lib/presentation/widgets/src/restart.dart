import 'package:flutter/material.dart';

class Restart extends StatefulWidget {
  const Restart({super.key, this.child});

  final Widget? child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartState>()!.restartApp();
  }

  @override
  State<Restart> createState() => _RestartState();
}

class _RestartState extends State<Restart> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child!,
    );
  }
}
