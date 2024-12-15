import 'package:flutter/material.dart';
import 'appointmentsModel.dart';
import 'package:intl/intl.dart';

class AppointmentsList extends StatelessWidget {
  final VoidCallback onAdd;
  final Function(int) onEdit;

  const AppointmentsList({super.key, required this.onAdd, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Appointments")),
      body: AnimatedBuilder(
        animation: appointmentsModel,
        builder: (context, _) {
          final appointments = appointmentsModel.appointments;

          return ListView.builder(
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              final appointment = appointments[index];
              final formattedDate =
              DateFormat.yMMMMd().add_jm().format(appointment.dateTime);

              return ListTile(
                title: Text(appointment.title),
                subtitle: Text(formattedDate),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => onEdit(appointment.id),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => appointmentsModel.deleteAppointment(appointment.id),
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
