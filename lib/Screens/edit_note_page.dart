import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../constants/fuctions.dart';
import '../constants/varibles.dart';
import '../models/note.dart';
import '../provider/note_provider.dart';
import '../constants/enums.dart';
import '../widgets/add_edit_body.dart';
import 'home_page.dart';

class EditNoteScreen extends StatelessWidget {
  // static const String id = 'editNote_screen';
  final Note note;

  const EditNoteScreen({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController bodyController = TextEditingController();
    titleController.text = note.title;
    bodyController.text = note.body;
    return Consumer<NoteProvider>(
      builder: (BuildContext context, NoteProvider value, Widget? child) =>
          Scaffold(
        appBar: AppBar(
          title: const Text(
            "Edit Your Note",
            style: titleBartextStyle,
          ),
        ),
        body: AddOrEditBody(
          bodyController: bodyController,
          titleController: titleController,
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            if (bodyController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                snackBarFuction(
                  content: const Text(
                    'There is nothing to save',
                  ),
                ),
              );
            } else {
              formattedDate;

              // Delete the old note
              await value.deleteNote(note.id);
              // Add the updated note
              value.addOrUpdate(
                titleController.text,
                bodyController.text,
                formattedDate,
                EditMode.UPDATE,
                note.id,
              );
              value
                  .addOrUpdate(
                    titleController.text,
                    bodyController.text,
                    formattedDate,
                    EditMode.ADD,
                    note.id,
                  ) // to back to specifinc place use popuntil and define the palce
                  .then<void>((void value) => Navigator.popUntil(
                      context, ModalRoute.withName(HomeScreen.id)))
                  .then((value) => ScaffoldMessenger.of(context).showSnackBar(
                        snackBarFuction(
                          content: const Text(
                            'Note Has Been Edited',
                          ),
                        ),
                      ));
            }
          },
          label: const Text("Edit Note"),
          icon: const Icon(Icons.save),
        ),
      ),
    );
  }
}
// done