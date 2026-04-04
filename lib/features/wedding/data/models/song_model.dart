import 'package:wedding_witness_app/features/wedding/domain/entities/song.dart';

class SongModel extends Song {
  SongModel({
    required super.id,
    required super.title,
    required super.fileName,
    super.moment = '',
  });

  // Méthode pour convertir un JSON en SongModel
  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
      id: json['id'],
      title: json['title'],
      fileName: json['fileName'],
      moment: json['moment'] as String? ?? '',
    );
  }

  // Méthode pour convertir SongModel en Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'fileName': fileName,
      'moment': moment,
    };
  }
}
