import 'package:flutter/material.dart';

class EnterNewHabitBox extends StatelessWidget {
  const EnterNewHabitBox({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.cyan[100],
      content: const TextField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 2.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 2.0,
            ),
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.black)),
          onPressed: () {},
          child: const Text(
            'Save',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        ElevatedButton(
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.black),
          ),
          onPressed: () {},
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
