import 'package:flutter/material.dart';
import 'contactsList.dart';
import 'contactsEntry.dart';
import 'contactsModel.dart';

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  int _currentIndex = 0;
  int? _editingContactId;

  void _showEntryScreen([int? contactId]) {
    setState(() {
      _currentIndex = 1;
      _editingContactId = contactId;
    });
  }

  void _showListScreen() {
    setState(() {
      _currentIndex = 0;
      _editingContactId = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: _currentIndex,
      children: [
        ContactsList(onAdd: _showEntryScreen, onEdit: _showEntryScreen),
        ContactsEntry(contactId: _editingContactId, onSave: _showListScreen),
      ],
    );
  }
}
