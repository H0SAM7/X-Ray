
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void showCustomAlert({
  required BuildContext context,
  required AlertType type,
  required String title,
  required String description,
  required VoidCallback onPressed,
    required String actionTitle,

}) {
  Alert(
    context: context,
    type: type,
    title: title,
    desc: description,
    buttons: [
      DialogButton(
        onPressed: onPressed,
        width: 120,
        child: Text(
          actionTitle,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    ],
  ).show();
}

// void showErrorAlert(BuildContext context) {
//   Alert(
//     context: context,
//     type: AlertType.error,
//     title: "Error",
//     desc: "Flutter is more awesome with RFlutter Alert.",
//     buttons: [
//       DialogButton(
//         child: Text(
//           "COOL",
//           style: TextStyle(color: Colors.white, fontSize: 20),
//         ),
//         onPressed: () => Navigator.pop(context),
//         width: 120,
//       ),
//     ],
//   ).show();
// }
