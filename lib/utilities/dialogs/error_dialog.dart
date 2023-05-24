import 'package:flutter/material.dart';
import 'package:skylancerafew/utilities/dialogs/generic_dialog.dart';
// import 'package:mynotes/extensions/buildcontext/loc.dart';


Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog<void>(
    context: context,
    title: 'An Error Occurred',
    content: text,
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
