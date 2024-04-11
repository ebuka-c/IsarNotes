import 'package:flutter/material.dart';
import 'package:my_notes/models/note.dart';
import 'package:my_notes/models/note_database.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  //text controller to access what the user typed
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // on app startup, fetch the existing notes
    readNotes();
  }

  //function to create a note
  void createNote() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(
                controller: textController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Add new note',
                ),
              ),
              actions: [
                //create button
                MaterialButton(
                    color: Colors.purple[500],
                    textColor: Colors.white,
                    onPressed: () {
                      context.read<NoteDatabase>().addNote(textController.text);
                      Navigator.pop(context);
                      textController.clear();
                    },
                    child: const Text('Create'))
              ],
            ));
  }

  //read notes
  void readNotes() {
    context.read<NoteDatabase>().fetchNotes();
  }

  //update note
  void updateNote(Note note) {
    //pre-fill the current note text into our controller
    textController.text = note.text;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Update Note'),
              content: TextField(controller: textController),
              actions: [
                MaterialButton(
                    onPressed: () {
                      //update note in db
                      context
                          .read<NoteDatabase>()
                          .updateNote(note.id, textController.text);
                      //clear the controller
                      textController.clear();
                      //pop dialog box
                      Navigator.pop(context);
                    },
                    child: const Text('Update'))
              ],
            ));
  }

  //delete a note
  void deleteNote(int id) {
    context.read<NoteDatabase>().deleteNote(id);
  }

  @override
  Widget build(BuildContext context) {
    //note database
    final noteDatabase = context.watch<NoteDatabase>();

    //current notes
    List<Note> currentNotes = noteDatabase.currentNotes;
    return Scaffold(
      appBar: AppBar(title: const Text('Notes')),
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: currentNotes.length,
          itemBuilder: (context, index) {
            // get individual note
            final note = currentNotes[index];
            //list tile ui
            return ListTile(
              title: Text(note.text),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //edit button
                  IconButton(
                      onPressed: () => updateNote(note),
                      icon: const Icon(Icons.edit)),
                  //delete button
                  IconButton(
                      onPressed: () => deleteNote(note.id),
                      icon: const Icon(Icons.delete))
                ],
              ),
            );
          }),
    );
  }
}
