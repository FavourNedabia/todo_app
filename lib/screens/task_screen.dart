import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/screens/add_task_screen.dart';
import 'package:todo_app/services/task_service.dart';


class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  // Liste des catégories de tâche
  final List<String> categories = [
    '💼',
    '💊',
    '💸',
    '👛',
    '🤷‍♀️',
    '🧼',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          String emoji = categories[index];
          return ListTile(
            leading: Text(
              emoji,
              style: TextStyle(fontSize: 30.0),
            ),
            onTap: () {
              // Action à effectuer lorsqu'une catégorie est tapée
              print('Category tapped: $emoji');
            },
          );
        },
      ),
    );
  }
}
