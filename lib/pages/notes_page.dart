import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_notes/models/note.dart';
import 'package:my_notes/models/note_database.dart';
import 'package:provider/provider.dart';

import '../components/drawer.dart';
import '../components/noteTile.dart';

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
              backgroundColor: Theme.of(context).colorScheme.primary,
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
                    textColor: Colors.white,
                    onPressed: () {
                      if (textController.text.isNotEmpty) {
                        context
                            .read<NoteDatabase>()
                            .addNote(textController.text);
                        Navigator.pop(context);
                        textController.clear();
                      }
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
              title: const Text('Update Note'),
              content: TextField(controller: textController),
              backgroundColor: Theme.of(context).colorScheme.primary,
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
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            foregroundColor: Theme.of(context).colorScheme.inversePrimary),
        drawer: const MyDrawer(),
        floatingActionButton: FloatingActionButton(
            onPressed: createNote,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Icon(Icons.add,
                color: Theme.of(context).colorScheme.inversePrimary)),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Text('Notes',
                  style: GoogleFonts.dmSerifDisplay(
                      fontSize: 48,
                      color: Theme.of(context).colorScheme.inversePrimary))),
          Expanded(
              child: ListView.builder(
                  itemCount: currentNotes.length,
                  itemBuilder: (context, index) {
                    // get individual note
                    final note = currentNotes[index];
                    //list tile ui
                    return NoteTile(
                      text: note.text,
                      onEditPressed: () => updateNote(note),
                      onDeletePressed: () => deleteNote(note.id),
                    );
                  }))
        ]));
  }
}
