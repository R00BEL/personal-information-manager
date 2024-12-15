import 'package:flutter/material.dart';
import 'notesModel.dart';

class NotesEntry extends StatefulWidget {
  final int? noteId;
  final VoidCallback onSave;

  const NotesEntry({super.key, this.noteId, required this.onSave});

  @override
  State<NotesEntry> createState() => _NotesEntryState();
}

class _NotesEntryState extends State<NotesEntry> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _content;

  @override
  void initState() {
    super.initState();
    if (widget.noteId != null) {
      final note = notesModel.notes
          .firstWhere((note) => note.id == widget.noteId);
      _title = note.title;
      _content = note.content;
    } else {
      _title = '';
      _content = '';
    }
  }

  void _saveNote() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (widget.noteId == null) {
        notesModel.addNote(_title, _content);
      } else {
        notesModel.updateNote(widget.noteId!, _title, _content);
      }
      widget.onSave();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add/Edit Note")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: const InputDecoration(labelText: "Title"),
                validator: (value) =>
                value == null || value.isEmpty ? "Title is required" : null,
                onSaved: (value) => _title = value!,
              ),
              TextFormField(
                initialValue: _content,
                decoration: const InputDecoration(labelText: "Content"),
                maxLines: 5,
                validator: (value) =>
                value == null || value.isEmpty ? "Content is required" : null,
                onSaved: (value) => _content = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveNote,
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
