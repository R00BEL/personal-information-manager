import 'package:flutter/material.dart';
import 'contactsModel.dart';

class ContactsList extends StatelessWidget {
  final VoidCallback onAdd;
  final Function(int) onEdit;

  const ContactsList({super.key, required this.onAdd, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contacts")),
      body: AnimatedBuilder(
        animation: contactsModel,
        builder: (context, _) {
          final contacts = contactsModel.contacts;

          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              final contact = contacts[index];

              return ListTile(
                title: Text(contact.name),
                subtitle: Text(contact.phone),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => onEdit(contact.id),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => contactsModel.deleteContact(contact.id),
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
