import 'package:flutter/material.dart';

class AddOrEditBody extends StatelessWidget {
  const AddOrEditBody({
    super.key,
    required this.titleController,
    required this.bodyController,
  });

  final TextEditingController titleController;
  final TextEditingController bodyController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: Column(
        children: <Widget>[
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Note Title",
            ),
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          const Divider(thickness: 2),
          Expanded(
            child: TextField(
              controller: bodyController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Write Your Note",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// done