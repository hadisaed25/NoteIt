import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/fuctions.dart';
import '../provider/note_provider.dart';
import '../screens/details_note_page.dart';
import 'dismissible_widget.dart';

class BodyWidget extends StatelessWidget {
  final List<String> noteTitles;

  const BodyWidget({
    Key? key,
    required this.noteTitles,
    // required this.notesbody,
    // required this.notesdate
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<NoteProvider>(
      builder: (BuildContext context, NoteProvider value, Widget? child) =>
          value.items.isEmpty
              ? const Center(child: Text('Your Note List is Empty'))
              : ListView.separated(
                  itemBuilder: (BuildContext context, int index) => Card(
                    child: DismissibleWidget(
                      key: ValueKey<int>(value.items[index].id),
                      onDismissed: (action) =>
                          dismissSlidableItem(context, index, action, value),
                      listTileWidget: ListTile(
                        onTap: () {
                          Navigator.push<dynamic>(
                            context,
                            MaterialPageRoute<dynamic>(
                              builder: (BuildContext context) => NoteDetails(
                                title: value.items[index].title,
                                body: value.items[index].body,
                                notes: value.items[index],
                                creationDates: value.items[index].creationDate,
                              ),
                            ),
                          );
                        },
                        title: Text(
                          value.items[index].title.isEmpty
                              ? 'No Title'
                              : value.items[index].title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        subtitle: Text(
                          value.items[index].body,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        trailing: Text(
                          value.items[index].creationDate,
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                  ),
                  separatorBuilder: (BuildContext context, int index) =>
                      Container(
                    width: double.infinity,
                    height: 1.0,
                    color: Colors.grey[300],
                  ),
                  itemCount: value.items.length,
                ),
    );
  }
}
// done