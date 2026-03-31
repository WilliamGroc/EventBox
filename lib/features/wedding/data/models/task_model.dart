import 'package:wedding_witness_app/features/wedding/domain/entities/task.dart';

class TaskModel extends Task {
  TaskModel({
    required super.id,
    super.title,
    super.description,
    super.startTime,
    super.isCompleted,
  });

  // Méthode pour convertir un JSON en TaskModel
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      startTime: json['startTime'],
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  // Méthode pour convertir TaskModel en Map (pour la persistance)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
      'description': description,
      'startTime': startTime,
    };
  }
}
