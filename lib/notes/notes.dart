import 'package:flutter/material.dart';
import 'notesList.dart';
import 'notesEntry.dart';
import 'notesModel.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  int _currentIndex = 0;
  int? _editingNoteId;

  void _showEntryScreen([int? noteId]) {
    setState(() {
      _currentIndex = 1;
      _editingNoteId = noteId;
    });
  }

  void _showListScreen() {
    setState(() {
      _currentIndex = 0;
      _editingNoteId = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: _currentIndex,
      children: [
        NotesList(onAdd: _showEntryScreen, onEdit: _showEntryScreen),
        NotesEntry(noteId: _editingNoteId, onSave: _showListScreen),
      ],
    );
  }
}
