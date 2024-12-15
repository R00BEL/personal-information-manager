import 'package:flutter/material.dart';
import 'appointmentsModel.dart';
import 'package:intl/intl.dart';


class AppointmentsEntry extends StatefulWidget {
  final int? appointmentId;
  final VoidCallback onSave;

  const AppointmentsEntry({super.key, this.appointmentId, required this.onSave});

  @override
  State<AppointmentsEntry> createState() => _AppointmentsEntryState();
}

class _AppointmentsEntryState extends State<AppointmentsEntry> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late DateTime _dateTime;

  @override
  void initState() {
    super.initState();
    if (widget.appointmentId != null) {
      final appointment =
      appointmentsModel.appointments.firstWhere((appointment) => appointment.id == widget.appointmentId);
      _title = appointment.title;
      _dateTime = appointment.dateTime;
    } else {
      _title = '';
      _dateTime = DateTime.now();
    }
  }

  void _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _dateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_dateTime),
      );

      if (time != null) {
        setState(() {
          _dateTime = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  void _saveAppointment() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (widget.appointmentId == null) {
        appointmentsModel.addAppointment(_title, _dateTime);
      } else {
        appointmentsModel.updateAppointment(widget.appointmentId!, _title, _dateTime);
      }
      widget.onSave();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add/Edit Appointment")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: const InputDecoration(labelText: "Appointment Title"),
                validator: (value) =>
                value == null || value.isEmpty ? "Title is required" : null,
                onSaved: (value) => _title = value!,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text("Date & Time: ${DateFormat.yMMMMd().add_jm().format(_dateTime)}"),
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: _pickDateTime,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveAppointment,
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
