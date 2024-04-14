import 'package:flutter/material.dart';
import 'package:note_book_app/Screens/search_page.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';
// import 'package:share_plus/share_plus.dart';
import '../Constants/fuctions.dart';
import '../constants/colors.dart';
import '../constants/varibles.dart';
import '../provider/note_provider.dart';
import '../widgets/home_body_widget.dart';
import '../widgets/popup_button_widget.dart';
import 'add_note_page.dart';
// Import the search screen

class HomeScreen extends StatelessWidget {
  static const String id = 'home_screen'; // a unique identifier

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // the dialog of reting
    final RatingDialog dialog = ratingMethod(context);

    return FutureBuilder<void>(
      future: Provider.of<NoteProvider>(context, listen: false).loadNotes(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final NoteProvider noteProvider = Provider.of<NoteProvider>(context);
          // the an instance of the title of the notes
          final List<String> noteTitles =
              noteProvider.items.map<String>((note) => note.title).toList();

          return Scaffold(
            appBar: AppBar(
              backgroundColor: lightBrown,
              title: const Text(
                "Your Notes",
                style: titleBartextStyle,
              ),
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    showSearch<String>(
                        context: context,
                        delegate: SearchPage(
                          notesTitle: noteTitles,
                        ));
                  },
                  icon: const Icon(Icons.search),
                ),
                // the popup button that have info & share & rating dialog
                PopupButtonWidget(dialog: dialog)
              ],
            ),
            bottomNavigationBar: bottomBarMethod(context),
            body: BodyWidget(
              noteTitles: noteTitles,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) => AddNoteScreen()),
                );
              },
              child: const Icon(Icons.note_add),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text("Please Wait..."),
          ),
          body: Center(
            child: CircularProgressIndicator(color: darkBrown),
          ),
        );
      },
    );
  }
}
// done