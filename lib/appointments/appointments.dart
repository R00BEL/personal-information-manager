import 'package:flutter/material.dart';
import 'appointmentsList.dart';
import 'appointmentsEntry.dart';

class Appointments extends StatefulWidget {
  const Appointments({super.key});

  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  int _currentIndex = 0;
  int? _editingAppointmentId;

  void _showEntryScreen([int? appointmentId]) {
    setState(() {
      _currentIndex = 1;
      _editingAppointmentId = appointmentId;
    });
  }

  void _showListScreen() {
    setState(() {
      _currentIndex = 0;
      _editingAppointmentId = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: _currentIndex,
      children: [
        AppointmentsList(onAdd: _showEntryScreen, onEdit: _showEntryScreen),
        AppointmentsEntry(appointmentId: _editingAppointmentId, onSave: _showListScreen),
      ],
    );
  }
}
