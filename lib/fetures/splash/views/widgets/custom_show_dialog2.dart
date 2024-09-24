

import 'package:flutter/material.dart';

class ConfirmationDialog2 extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;
  final String action;
  const ConfirmationDialog2({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm, required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          child: Text(action),
          onPressed: () {
         onConfirm();
          },
        ),
        // TextButton(
        //   child: Text('5555'),
        //   onPressed: () {
        //     onConfirm();
        //   },
        // ),
      ],
    );
  }
}




