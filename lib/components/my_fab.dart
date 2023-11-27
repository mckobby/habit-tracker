import 'package:flutter/material.dart';

class MyFloatingActionButton extends StatelessWidget {
  final Function()? onPressed;
  const MyFloatingActionButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.cyan[500],
      onPressed: onPressed,
      child: const Icon(Icons.add),
    );
  }
}
