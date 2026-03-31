import 'package:wedding_witness_app/features/wedding/domain/entities/song.dart';

class SongModel extends Song {
  SongModel({
    required super.id,
    required super.title,
    required super.fileName
  });

  // Méthode pour convertir un JSON en TaskModel
  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
      id: json['id'],
      title: json['title'],
      fileName: json['fileName'],
    );
  }

  // Méthode pour convertir TaskModel en Map (pour la persistance)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'fileName': fileName,
    };
  }
}
