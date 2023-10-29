import 'package:flutter/material.dart';

Future<dynamic> alertDailogue(
  BuildContext context,
  String heading,
  Function() onTapOk,
  String subHeading,
) {
  return showDialog(
      context: context,
      builder: (builder) {
        return AlertDialog(
          title: Text(heading),
          content: Text(subHeading),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: onTapOk,
              child: const Text('OK'),
            ),
          ],
        );
      });
}
