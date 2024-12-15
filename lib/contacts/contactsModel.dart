import 'package:flutter/material.dart';

class Contact {
  final int id;
  final String name;
  final String phone;
  final String email;

  Contact({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
  });
}

class ContactsModel with ChangeNotifier {
  List<Contact> _contacts = [];
  int _nextId = 1;

  List<Contact> get contacts => List.unmodifiable(_contacts);

  void addContact(String name, String phone, String email) {
    _contacts.add(Contact(id: _nextId++, name: name, phone: phone, email: email));
    notifyListeners();
  }

  void updateContact(int id, String name, String phone, String email) {
    final index = _contacts.indexWhere((contact) => contact.id == id);
    if (index != -1) {
      _contacts[index] = Contact(id: id, name: name, phone: phone, email: email);
      notifyListeners();
    }
  }

  void deleteContact(int id) {
    _contacts.removeWhere((contact) => contact.id == id);
    notifyListeners();
  }
}

final contactsModel = ContactsModel();
