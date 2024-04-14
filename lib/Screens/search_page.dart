import 'package:flutter/material.dart';

import '../widgets/search_body.dart';

class SearchPage extends SearchDelegate<String> {
  final List<String> notesTitle; // List of notes titles
  SearchPage({
    required this.notesTitle,
  });

  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchBody(query: query, notesTitle: notesTitle);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SearchBody(
      query: query,
      notesTitle: notesTitle,
    );
  }
}
// done