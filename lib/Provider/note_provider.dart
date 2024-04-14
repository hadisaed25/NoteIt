import 'package:flutter/material.dart';
import '../constants/enums.dart';
import '../models/note.dart';
import '../services/sqlite.dart';

class NoteProvider with ChangeNotifier {
  // an instance of sqlitehelper class
  final SQliteHelper _db = SQliteHelper();
// declare an list of items and intilze with empty list
  List<Note> _items = <Note>[];
// fuction to load notes from database
  Future<void> loadNotes() async {
    List<Map<String, dynamic>> data = await _db.notes;
    _items = data.map<Note>((Map<String, dynamic> note) {
      return Note(
        id: note['id'],
        title: note['title'],
        body: note['body'],
        creationDate: note['creationDate'],
      );
    }).toList();
    notifyListeners();
  }

// fuction to add or update notes
  Future<void> addOrUpdate(
    String title,
    String body,
    String creationDate,
    EditMode editMode,
    int id,
  ) async {
    // try {
    int newId = id != 0 ? id : UniqueKey().hashCode;

    id = await _db.insertNote(
      Note(
        id: newId,
        title: title,
        body: body,
        creationDate: creationDate,
      ).toMap(),
    );

    final Note note = Note(
      id: newId,
      title: title,
      body: body,
      creationDate: creationDate,
    );

    if (id != 0) {
      if (editMode == EditMode.ADD) {
        _items.insert(0, note);
      } else if (editMode == EditMode.UPDATE) {
        _items[_items.indexWhere((Note element) => element.id == note.id)] =
            note;
      }
      notifyListeners();
    }
    // }
    // catch (e) {
    // Handle error
    // print("Error: $e");
    // }
  }

// fuciton to delete note by missalbe
  Future<void> deleteNote(int id) async {
    // try {
    _items.removeWhere((Note element) => element.id == id);
    await _db.deleteNote(id);
    notifyListeners();
    // } catch (e) {
    // Handle error
    //   print("Error: $e");
    // }
  }

  List<Note> get items =>
      <Note>[..._items]; // ... this to extract the list in another list
}
// done