import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';
import '../provider/note_provider.dart';
import '../screens/details_note_page.dart';

class SearchBody extends StatelessWidget {
  const SearchBody({
    super.key,
    required this.query,
    required this.notesTitle,
  });

  final String query;
  final List<String> notesTitle;

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteProvider>(
        builder: (BuildContext context, NoteProvider noteProvider, Widget? _) {
      final List<String> suggestionList = query.isEmpty
          ? notesTitle
              .where((String note) => note.isNotEmpty)
              .toList() // Filter out notes without titles when query is empty
          : notesTitle
              .where((note) => note.toLowerCase().contains(query.toLowerCase()))
              .toList();
      final List<String> noteDate = noteProvider.items
          .map<String>((Note note) => note.creationDate)
          .toList();
      final List<String> noteTitles =
          noteProvider.items.map<String>((Note note) => note.title).toList();
      final List<String> notesBody =
          noteProvider.items.map<String>((Note note) => note.body).toList();
      final List<Note> notes = noteProvider.items;
      return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text(suggestionList[index]),
              subtitle: Text(
                noteDate[index],
                style:
                    const TextStyle(fontStyle: FontStyle.italic, fontSize: 11),
              ),
              trailing: const Icon(Icons.arrow_forward_rounded),
              onTap: () {
                // query = suggestionList[index];
                Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) => NoteDetails(
                      title: noteTitles[index],
                      body: notesBody[index],
                      notes: notes[index],
                      creationDates: noteDate[index],
                    ),
                  ),
                );
                // Perform search using the selected suggestion
              },
            ),
          );
        },
      );
    });
  }
}
// done