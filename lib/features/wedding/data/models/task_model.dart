import 'package:wedding_witness_app/features/wedding/domain/entities/task.dart';

class TaskModel extends Task {
  TaskModel({
    required super.id,
    super.title,
    super.description,
    super.startTime,
    super.isCompleted,
    super.songId,
  });

  // Méthode pour convertir un JSON en TaskModel
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      startTime: json['startTime'],
      isCompleted: json['isCompleted'] ?? false,
      songId: (json['songId'] as int?) == 0 ? null : json['songId'] as int?,
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
      'songId': songId,
    };
  }
}
