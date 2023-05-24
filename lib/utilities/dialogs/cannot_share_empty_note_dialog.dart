import 'package:flutter/material.dart';
import 'package:skylancerafew/utilities/dialogs/generic_dialog.dart';

Future<void> showCannotShareEmptyNoteDialog(BuildContext context) {
  return showGenericDialog<void>(
    context: context,
    title: 'Empty',
    content: 'Can not share empty note',
    optionsBuilder: () => {
      'Ok': false,
      'Yes': true,
    },
  );
}
