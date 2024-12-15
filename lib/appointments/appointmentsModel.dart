import 'package:flutter/material.dart';

class Appointment {
  final int id;
  final String title;
  final DateTime dateTime;

  Appointment({
    required this.id,
    required this.title,
    required this.dateTime,
  });
}

class AppointmentsModel with ChangeNotifier {
  List<Appointment> _appointments = [];
  int _nextId = 1;

  List<Appointment> get appointments => List.unmodifiable(_appointments);

  void addAppointment(String title, DateTime dateTime) {
    _appointments.add(Appointment(id: _nextId++, title: title, dateTime: dateTime));
    notifyListeners();
  }

  void updateAppointment(int id, String title, DateTime dateTime) {
    final index = _appointments.indexWhere((appointment) => appointment.id == id);
    if (index != -1) {
      _appointments[index] = Appointment(id: id, title: title, dateTime: dateTime);
      notifyListeners();
    }
  }

  void deleteAppointment(int id) {
    _appointments.removeWhere((appointment) => appointment.id == id);
    notifyListeners();
  }
}

final appointmentsModel = AppointmentsModel();
