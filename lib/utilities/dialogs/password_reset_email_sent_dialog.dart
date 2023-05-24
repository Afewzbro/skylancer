import 'package:flutter/material.dart';
// import 'package:mynotes/extensions/buildcontext/loc.dart';
import 'package:skylancerafew/utilities/dialogs/generic_dialog.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialog<void>(
    context: context,
    title: 'Reset Password',
    content: 'Are you sure you want to reset your password?',
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
