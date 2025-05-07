import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showLoading(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        content: Row(
          children: [Text("Loading..."), Spacer(), CircularProgressIndicator()],
        ),
      );
    },
  );
}

void hideLoading(BuildContext context) => Navigator.pop(context);

void showMessage(
    BuildContext context, {
      String? title,
      String? content,
      String? posButtonTitle,
      String? negButtonTitle,
      Function? posButtonClick,
      Function? negButtonClick,
    }) {
  showDialog(
    context: context,
    builder: (_) {
      return CupertinoAlertDialog(
        title: title != null ? Text(title) : null,
        content: content != null ? Text(content) : null,
        actions: [
          if (negButtonTitle != null)
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                negButtonClick?.call();
              },
              child: Text(negButtonTitle),
            ),
          if (posButtonTitle != null)
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                posButtonClick?.call();
              },
              child: Text(posButtonTitle),
            ),
        ],
      );
    },
  );
}

