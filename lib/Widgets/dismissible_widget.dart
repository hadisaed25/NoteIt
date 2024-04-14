import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/enums.dart';

class DismissibleWidget extends StatelessWidget {
  @required
  final Widget listTileWidget;
  @required
  final Function(SlidableAction action) onDismissed;

  const DismissibleWidget({
    required Key key,
    required this.listTileWidget,
    required this.onDismissed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.horizontal,
      background: Container(
        color: gray,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20.0),
        child: const Icon(Icons.edit, color: Colors.white),
      ),
      secondaryBackground: Container(
        color: darkBrown,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          return await showDialog<bool>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Confirm Deletion \u26A0\ufe0f"),
                content:
                    const Text("Are you sure you want to delete this item?"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).pop<bool>(false),
                    child: Text("Cancel", style: TextStyle(color: meduimBrown)),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop<bool>(true),
                    child: const Text(
                      "Delete",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              );
            },
          );
        }
        return true;
      },
      onDismissed: (DismissDirection direction) {
        if (direction == DismissDirection.startToEnd) {
          onDismissed(SlidableAction.EDIT);
        } else if (direction == DismissDirection.endToStart) {
          onDismissed(SlidableAction.DELETE);
        }
      },
      child: listTileWidget,
    );
  }
}
// done