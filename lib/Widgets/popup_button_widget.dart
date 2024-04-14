import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:share_plus/share_plus.dart';

import '../constants/colors.dart';
import '../constants/fuctions.dart';

class PopupButtonWidget extends StatelessWidget {
  const PopupButtonWidget({
    super.key,
    required this.dialog,
  });

  final RatingDialog dialog;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry<int>>[
          popUpMenuItemMethod(
              value: 1, nameOfOption: 'About App', nameOfIcon: Icons.info),
          popUpMenuItemMethod(
              value: 2, nameOfOption: 'Share App', nameOfIcon: Icons.share),
          // change it later
          PopupMenuItem<int>(
            textStyle: TextStyle(color: meduimBrown),
            value: 3,
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.rate_review,
                  color: meduimBrown,
                ),
                const Text('  Rate App'),
              ],
            ),
          )
        ];
      },
      onSelected: (int value) {
        if (value == 1) {
          showAboutDialog(
            children: <Widget>[const Text('A note book app build in Flutter')],
            context: context,
            applicationName: 'Note It',
            applicationVersion: 'v1.0.0',
            applicationIcon: Image.asset(
              'assets/images/logo.png',
              width: 70.0,
            ),
          );
        } else if (value == 2) {
          Share.share('https://github.com/hadisaed25/',
              subject: 'Hello Welcome to My App');
          // print('hhhhhhhhhh');
        } else if (value == 3) {
          showDialog<dynamic>(
            context: context,
            barrierDismissible:
                true, // set to false if you want to force a rating
            builder: (BuildContext context) => dialog,
          );
        }
      },
    );
  }
}
// done
