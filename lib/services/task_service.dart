import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/models/task.dart';

class TaskService {
  static List<Task> tasks = [];

  // Récupérer la liste des tâches depuis SharedPreferences
  static Future<bool> getTaskList() async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      List<String>? taskList = pref.getStringList('tasks');
      if (taskList != null) {
        tasks = taskList.map((taskJson) => Task.fromJson(jsonDecode(taskJson))).toList();
      } else {
        tasks = [];
      }
      return true;
    } catch (e) {
      print('Erreur lors de la récupération des tâches: $e');
      return false;
    }
  }

  // Sauvegarder une tâche dans SharedPreferences
  static Future<void> saveTask(Task task) async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      tasks.add(task);
      List<String> taskList = tasks.map((task) => jsonEncode(task.toJson())).toList();
      await pref.setStringList('tasks', taskList);
    } catch (e) {
      print('Erreur lors de la sauvegarde de la tâche: $e');
    }
  }

  // Supprimer une tâche de SharedPreferences
  static Future<void> deleteTask(Task task) async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      tasks.remove(task);
      List<String> taskList = tasks.map((task) => jsonEncode(task.toJson())).toList();
      await pref.setStringList('tasks', taskList);
    } catch (e) {
      print('Erreur lors de la suppression de la tâche: $e');
    }
  }
}
