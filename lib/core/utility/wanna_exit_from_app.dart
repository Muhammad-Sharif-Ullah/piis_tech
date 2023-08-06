import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piis_tech/config/config.dart';
import 'package:piis_tech/core/constants/resources.dart';

Future<bool> wannaExitFromApp(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Row(
          children: [
            Image.asset(R.ASSETS_IMAGES_PIIS_TECH_LOGO_PNG,
                height: 25, width: 25),
            const Spacer(),
            const Text('Exit From ${AppConfiguration.appName}?'),
            const Spacer(),
          ],
        ),
        content: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Are you sure you want to exit from the app?'),
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: () {
              Navigator.of(context)
                  .pop(true); // Dismiss the dialog and return true
            },
            child: const Text(
              'Exit',
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
          CupertinoDialogAction(
            onPressed: () {
              Navigator.of(context)
                  .pop(false); // Dismiss the dialog and return false
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.green),
            ),
          ),
        ],
      );
    },
  );
}
