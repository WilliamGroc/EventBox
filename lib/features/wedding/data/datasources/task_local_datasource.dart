import 'package:dio/dio.dart';
import 'package:wedding_witness_app/features/wedding/data/models/task_model.dart';

abstract class TaskLocalDataSource {
  Future<List<TaskModel>> getTasks();
  Future<void> updateTask(TaskModel task);
}

class TaskLocalDataSourceImpl implements TaskLocalDataSource  {
  final Dio dio;

  TaskLocalDataSourceImpl({required this.dio});

  @override
  Future<List<TaskModel>> getTasks() async {
    try {
      final response = await dio.get('tasks');

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => TaskModel.fromJson(json)).toList();
      } else {
        print(
          'Erreur lors de la récupération des tâches : ${response.statusCode}',
        );
        return [];
      }
    } catch (e) {
      print('Erreur lors de la lecture : $e');
      return []; // Retourne une liste vide en cas d'erreur
    }
  }

  @override
  Future<void> updateTask(TaskModel task) async {
    try {
      final response = await dio.put('tasks/${task.id}', data: task.toJson());

      if (response.statusCode != 200) {
        print('Erreur lors de la mise à jour : ${response.statusCode}');
      }
    } catch (e) {
      print('Erreur lors de la mise à jour : $e');
    }
  }
}
