class Note {
  final int id;
  final String title;
  final String body;
  final String creationDate;

  Note(
      {required this.id,
      required this.title,
      required this.body,
      required this.creationDate});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'body': body,
      'creationDate': creationDate,
    };
  }
}
// done