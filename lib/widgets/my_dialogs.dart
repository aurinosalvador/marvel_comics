import 'package:flutter/material.dart';

class MyDialogs {
  static Future<void> show(
    BuildContext context,
    String message, {
    String title = 'Atenção',
    String buttonText = 'OK',
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              buttonText,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  static void yesNo({
    @required BuildContext context,
    @required String message,
    @required Function onYes,
    String title = 'Atenção',
    String yesLabel = 'Sim',
    String noLabel = 'Não',
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(noLabel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).colorScheme.surface,
            ),
            onPressed: () {
              onYes();
              Navigator.of(context).pop();
            },
            child: Text(
              yesLabel,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static void showToast(BuildContext context, String message) {
    final ScaffoldMessengerState scaffold = ScaffoldMessenger.of(context);

    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
