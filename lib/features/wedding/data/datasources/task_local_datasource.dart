import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wedding_witness_app/features/wedding/data/models/task_model.dart';

abstract class TaskLocalDataSource {
  Future<List<TaskModel>> getTasks();
  Future<void> updateTask(TaskModel task);
}

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  Future<List<TaskModel>> _getLocalFile() async {
    final directory = await getApplicationCacheDirectory();
    File file = File('${directory.path}/assets/tasks.json');
    String jsonString;

    if (!await file.exists()) {
      jsonString = await rootBundle.loadString('assets/tasks.json');
    } else {
      jsonString = await file.readAsString();
    }

    final List<dynamic> jsonList =  jsonDecode(jsonString);

    return jsonList.map((json) => TaskModel.fromJson(json)).toList();
  }

  Future<void> _writeLocalFile(List<TaskModel> tasks) async {
    final directory = await getApplicationCacheDirectory();
    File file = File('${directory.path}/assets/tasks.json');

    if (!await file.exists()) {
      await file.create(recursive: true);
    }

    final String jsonString = jsonEncode(
      tasks.map((t) => t.toJson()).toList(),
    );
    await file.writeAsString(jsonString);
  }

  @override
  Future<List<TaskModel>> getTasks() async {
    try {
      return _getLocalFile();
    } catch (e) {
      print('Erreur lors de la lecture : $e');
      return []; // Retourne une liste vide en cas d'erreur
    }
  }

  @override
  Future<void> updateTask(TaskModel task) async {
    try {
      List<TaskModel> tasks = await _getLocalFile();

      // 3. Mettre à jour la tâche dans la liste
      int index = tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        tasks[index] = task; // Met à jour la tâche existante
      } else {
        tasks.add(task); // Ajoute une nouvelle tâche si elle n'existe pas
      }

      // 4. Écrire la liste mise à jour dans le fichier
      await _writeLocalFile(tasks);
    } catch (e) {
      print('Erreur lors de la mise à jour : $e');
    }
  }
}
