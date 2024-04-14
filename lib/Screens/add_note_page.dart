import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/fuctions.dart';
import '../constants/varibles.dart';
import '../provider/note_provider.dart';
import '../constants/enums.dart';
import '../widgets/add_edit_body.dart';
// Import the AddBodyWidget class

class AddNoteScreen extends StatelessWidget {
  // static const String id = 'addNote_screen';

  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  AddNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteProvider>(
      builder: (BuildContext context, NoteProvider value, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Add New Note",
              style: titleBartextStyle,
            ),
          ),
          body: AddOrEditBody(
              titleController: titleController, bodyController: bodyController),
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
                value
                    .addOrUpdate(
                      titleController.text,
                      bodyController.text,
                      formattedDate,
                      EditMode.ADD,
                      0,
                    )
                    .then<void>(
                        (void value) => Navigator.pop<Object?>(context));
              }
            },
            label: const Text("Save Note"),
            icon: const Icon(Icons.save),
          ),
        );
      },
    );
  }
}
// done