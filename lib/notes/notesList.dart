import 'package:flutter/material.dart';
import 'notesModel.dart';

class NotesList extends StatelessWidget {
  final VoidCallback onAdd;
  final Function(int) onEdit;

  const NotesList({super.key, required this.onAdd, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notes")),
      body: AnimatedBuilder(
        animation: notesModel,
        builder: (context, _) {
          final notes = notesModel.notes;

          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];

              return ListTile(
                title: Text(note.title),
                subtitle: Text(note.content, maxLines: 1, overflow: TextOverflow.ellipsis),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => onEdit(note.id),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => notesModel.deleteNote(note.id),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onAdd,
        child: const Icon(Icons.add),
      ),
    );
  }
}
