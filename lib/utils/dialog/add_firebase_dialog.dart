import 'package:flutter/material.dart';
import '../constants/widget/add_firebase_dialog.dart' as add_firebase_dialog_constants;

class AddFirebaseDialog extends StatefulWidget {
  final String message;
  final void Function()? trueFunction;
  const AddFirebaseDialog(
      {super.key, required this.message, this.trueFunction});

  @override
  State<AddFirebaseDialog> createState() => _AddFirebaseState();

  static Future<void> show(
      BuildContext context, String message, void Function() trueFunction) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return PopScope(
            canPop: false,
            child:
                AddFirebaseDialog(message: message, trueFunction: trueFunction),
          );
        });
  }

  static Future<void> hide(BuildContext context) async {
    Navigator.of(context).pop();
  }
}

class _AddFirebaseState extends State<AddFirebaseDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.message),
      actions: <Widget>[
        TextButton(onPressed: widget.trueFunction, child: const Text(add_firebase_dialog_constants.trueText)),
        TextButton(
            onPressed: () => Navigator.pop(context), child: const Text(add_firebase_dialog_constants.falseText))
      ],
    );
  }
}
