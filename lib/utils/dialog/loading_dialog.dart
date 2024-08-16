import 'package:flutter/material.dart';

class LoadingDialog extends StatefulWidget {
  final String message;
  const LoadingDialog({super.key, required this.message});

  @override
  State<LoadingDialog> createState() => _LoadingDialogState();

  static Future<void> show(BuildContext context, String message) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return PopScope(
            canPop: false,
            child: LoadingDialog(message: message),
          );
        });
  }

  static Future<void> hide(BuildContext context) async {
    Navigator.of(context).pop();
  }
}

class _LoadingDialogState extends State<LoadingDialog> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 150,
        height: 150,
        child: AlertDialog(
          alignment: Alignment.center,
          contentPadding: EdgeInsets.zero,
          insetPadding: EdgeInsets.zero,
          content: _dialogContent(widget.message),
        ),
      ),
    );
  }

  Widget _dialogContent(String message) {
    return Column(
      children: [
        const Spacer(),
        const CircularProgressIndicator(),
        const Spacer(),
        Text(message),
        const Spacer(),
      ],
    );
  }
}
