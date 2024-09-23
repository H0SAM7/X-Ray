// import 'package:e_learing/core/widgets/custom_alert.dart';
// import 'package:e_learing/generated/l10n.dart';
// import 'package:flutter/material.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';

// void showErrorAlert(BuildContext context, String errorCode) {
//   final s = S.of(context);

//   String localizedErrorMessage;

//   switch (errorCode) {
//     case 'Permission denied to access Firestore.':
//       localizedErrorMessage = s.permission_denied;
//       break;
//     case 'Document not found in Firestore.':
//       localizedErrorMessage = s.document_not_found;
//       break;
//     case 'Firestore operation was aborted.':
//       localizedErrorMessage = s.operation_aborted;
//       break;
//     case 'Document already exists in Firestore.':
//       localizedErrorMessage = s.already_exists;
//       break;
//     case 'Firestore resource exhausted.':
//       localizedErrorMessage = s.resource_exhausted;
//       break;
//     case 'Firestore service is currently unavailable.':
//       localizedErrorMessage = s.service_unavailable;
//       break;
//     case 'Firestore operation timed out.':
//       localizedErrorMessage = s.deadline_exceeded;
//       break;
//     case 'Firestore request was cancelled.':
//       localizedErrorMessage = s.request_cancelled;
//       break;
//     case 'The email address is not valid.':
//       localizedErrorMessage = s.invalid_email;
//       break;
//     case 'The user account has been disabled.':
//       localizedErrorMessage = s.user_disabled;
//       break;
//     case 'No user found with this email.':
//       localizedErrorMessage = s.user_not_found;
//       break;
//     case 'Incorrect password.':
//       localizedErrorMessage = s.wrong_password;
//       break;
//     case 'The email is already in use.':
//       localizedErrorMessage = s.email_already_in_use;
//       break;
//     case 'The password is too weak.':
//       localizedErrorMessage = s.weak_password;
//       break;
//     case 'This operation is not allowed.':
//       localizedErrorMessage = s.operation_not_allowed;
//       break;
//     default:
//       localizedErrorMessage = s.unknown_firebase_error;
//       break;
//   }

//   showCustomAlert(
//     context: context,
//     type: AlertType.error,
//     description: localizedErrorMessage,
//     title: '',
//     actionTitle: s.ok, // Assuming 'ok' is also localized
//     onPressed: () {
//       Navigator.pop(context);
//     }
//   );
// }
