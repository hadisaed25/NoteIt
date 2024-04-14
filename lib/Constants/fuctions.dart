import 'package:flutter/material.dart';
import 'package:note_book_app/Constants/varibles.dart';
import 'package:rating_dialog/rating_dialog.dart';

import '../provider/note_provider.dart';
import '../screens/edit_note_page.dart';
import 'colors.dart';
import 'enums.dart';

// pass context for fuction and it will work in app
// the dimiss of card notes to delete or edit the note
void dismissSlidableItem(BuildContext context, int index, SlidableAction action,
    NoteProvider value) {
  switch (action) {
    case SlidableAction.EDIT:
      Navigator.push<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) =>
              EditNoteScreen(note: value.items[index]),
        ),
      ).then<void>((dynamic _) {
        ScaffoldMessenger.of(context).showSnackBar(
            snackBarFuction(content: const Text('Note has been Edited')));
      });
      break;
    case SlidableAction.DELETE:
      value.deleteNote(value.items[index].id);
      ScaffoldMessenger.of(context).showSnackBar(
          snackBarFuction(content: const Text('Note has been Deleted')));
      break;
  }
}

// SnackBar
SnackBar snackBarFuction({dynamic content}) {
  return SnackBar(
      dismissDirection: DismissDirection.endToStart,
      elevation: 100.0,
      closeIconColor: gray,
      showCloseIcon: true,
      backgroundColor: darkBrown.withOpacity(0.3),
      content: content);
}
// fuction of the popUp menu method

PopupMenuItem<int> popUpMenuItemMethod(
    {int? value, String? nameOfOption, dynamic nameOfIcon}) {
  return PopupMenuItem<int>(
    textStyle: TextStyle(color: meduimBrown),
    value: value,
    child: Row(
      children: <Widget>[
        Icon(
          nameOfIcon,
          color: meduimBrown,
        ),
        Text('  $nameOfOption'),
      ],
    ),
  );
}

RatingDialog ratingMethod(BuildContext context) {
  return RatingDialog(
      initialRating: 1.0,
      title: const Text('Rating My App',
          textAlign: TextAlign.center, style: titleBartextStyle),
      // encourage your user to leave a high rating?
      message: const Text(
        'Tap a star to set your rating. Add more description here if you want.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
      // your app's logo?
      starSize: 30,
      showCloseButton: true,
      submitButtonText: 'Submit',
      commentHint: 'Set your custom comment hint',
      // onCancelled: () => print('cancelled'),
      onSubmitted: (RatingDialogResponse response) {
        if (response.comment.isNotEmpty || response.rating >= 1.0) {
          ScaffoldMessenger.of(context).showSnackBar(snackBarFuction(
              content: Text(
                  'Thank you for rating us ${String.fromCharCode(0x1F929)}')));
        }
        // else {}
        // print('rating: ${response.rating}, comment: ${response.comment}');
        // if (response.rating < 3.0) {
        // for example here i can sent the response to my gmail
        // }
      });
}

// the navigation bottom bar
Container bottomBarMethod(dynamic context) {
  return Container(
    height: 50.0,
    decoration: BoxDecoration(
      color: lightBrown,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(30.0)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: darkBrown,
          offset: const Offset(0, -2),
          blurRadius: 6.0,
        ),
      ],
    ),
  );
}
// done