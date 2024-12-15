import 'package:flutter/material.dart';
import 'contactsModel.dart';

class ContactsEntry extends StatefulWidget {
  final int? contactId;
  final VoidCallback onSave;

  const ContactsEntry({super.key, this.contactId, required this.onSave});

  @override
  State<ContactsEntry> createState() => _ContactsEntryState();
}

class _ContactsEntryState extends State<ContactsEntry> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _phone;
  late String _email;

  @override
  void initState() {
    super.initState();
    if (widget.contactId != null) {
      final contact = contactsModel.contacts
          .firstWhere((contact) => contact.id == widget.contactId);
      _name = contact.name;
      _phone = contact.phone;
      _email = contact.email;
    } else {
      _name = '';
      _phone = '';
      _email = '';
    }
  }

  void _saveContact() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (widget.contactId == null) {
        contactsModel.addContact(_name, _phone, _email);
      } else {
        contactsModel.updateContact(widget.contactId!, _name, _phone, _email);
      }
      widget.onSave();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add/Edit Contact")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: const InputDecoration(labelText: "Name"),
                validator: (value) =>
                value == null || value.isEmpty ? "Name is required" : null,
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                initialValue: _phone,
                decoration: const InputDecoration(labelText: "Phone"),
                keyboardType: TextInputType.phone,
                validator: (value) =>
                value == null || value.isEmpty ? "Phone is required" : null,
                onSaved: (value) => _phone = value!,
              ),
              TextFormField(
                initialValue: _email,
                decoration: const InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                value == null || value.isEmpty ? "Email is required" : null,
                onSaved: (value) => _email = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveContact,
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
