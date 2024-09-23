import 'package:flutter/material.dart';
import 'package:x_ray2/core/widgets/custom_loading_indecator.dart';

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevents the user from dismissing the dialog
    builder: (BuildContext context) {
      return const Dialog(
        // Minimizing height with SizedBox
        child: SizedBox(
          width: 80,  // Width can be adjusted as needed
          height: 80, // Height minimized for a compact dialog
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: CustomLoadingIndicator(), // Custom loading indicator
          ),
        ),
      );
    },
  );
}

void hideLoadingDialog(BuildContext context) {
  Navigator.of(context).pop();
}
