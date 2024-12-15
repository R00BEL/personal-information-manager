import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'appointments/appointments.dart';
import 'contacts/contacts.dart';
import 'notes/notes.dart';
import 'tasks/tasks.dart';
import 'models/appModel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   return ScopedModel<AppModel>(
  //     model: AppModel(),
  //     child: MaterialApp(
  //       title: 'Flutter Book',
  //       theme: ThemeData(
  //         primarySwatch: Colors.blue,
  //       ),
  //       home: const DefaultTabController(
  //         length: 4,
  //         child: const Text("Flutter Book"),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Todo Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DefaultTabController(
        length: 4,
        child: Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Book"),
        bottom: const TabBar(
          tabs: [
            Tab(icon: Icon(Icons.calendar_today), text: "Appointments"),
            Tab(icon: Icon(Icons.contacts), text: "Contacts"),
            Tab(icon: Icon(Icons.note), text: "Notes"),
            Tab(icon: Icon(Icons.check), text: "Tasks"),
          ],
        ),
      ),
      body: const TabBarView(
        children: [
          Appointments(),
          Contacts(),
          Notes(),
          Tasks(),
        ],
      ),
    );
  }
}
