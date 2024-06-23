import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

import 'noteSettings.dart';

class NoteTile extends StatelessWidget {
  const NoteTile(
      {super.key,
      required this.text,
      this.onEditPressed,
      this.onDeletePressed});

  final String text;
  final void Function()? onEditPressed;
  final void Function()? onDeletePressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.only(top: 10, left: 25, right: 25),
      child: ListTile(
        title: Text(text),
        trailing: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => showPopover(
                width: 100,
                height: 100,
                backgroundColor: Theme.of(context).colorScheme.surface,
                context: context,
                bodyBuilder: (context) => Notesettings(
                    onEditTap: onEditPressed, onDeleteTap: onDeletePressed)),
          ),
        ),
        // trailing: Row(mainAxisSize: MainAxisSize.min, children: [
        //   IconButton(onPressed: onEditPressed, icon: const Icon(Icons.edit)),
        //   IconButton(onPressed: onDeletePressed, icon: const Icon(Icons.delete))
        // ]),
      ),
    );
  }
}
