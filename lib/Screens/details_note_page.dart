import 'package:flutter/material.dart';

import '../Constants/colors.dart';
import '../constants/varibles.dart';
import 'edit_note_page.dart';

class NoteDetails extends StatelessWidget {
  // static String details = 'details_screen';
  final String? title;
  final String? body;
  final String? creationDates;
  // ignore: prefer_typing_uninitialized_variables
  final dynamic notes;
  const NoteDetails(
      {super.key,
      required this.title,
      required this.body,
      required this.notes,
      required this.creationDates});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title!.isEmpty ? 'No Title' : title!,
            style: titleBartextStyle),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
                builder: (BuildContext context) => EditNoteScreen(
                      note: notes,
                    )),
          );
        },
        child: const Icon(Icons.edit_note),
      ),
      body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Card(
              child: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: RichText(
                        text: TextSpan(children: <InlineSpan>[
                          TextSpan(text: '$creationDates\n\n'),
                          TextSpan(
                              text: body,
                              style: TextStyle(fontSize: 22, color: darkBrown))
                        ]),
                      ))))),
    );
  }
}
// done