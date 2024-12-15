import 'package:flutter/material.dart';

class Note {
  final int id;
  final String title;
  final String content;

  Note({
    required this.id,
    required this.title,
    required this.content,
  });
}

class NotesModel with ChangeNotifier {
  List<Note> _notes = [];
  int _nextId = 1;

  List<Note> get notes => List.unmodifiable(_notes);

  void addNote(String title, String content) {
    _notes.add(Note(id: _nextId++, title: title, content: content));
    notifyListeners();
  }

  void updateNote(int id, String title, String content) {
    final index = _notes.indexWhere((note) => note.id == id);
    if (index != -1) {
      _notes[index] = Note(id: id, title: title, content: content);
      notifyListeners();
    }
  }

  void deleteNote(int id) {
    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
  }
}

final notesModel = NotesModel();
