import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wedding_witness_app/features/wedding/data/models/song_model.dart';
import 'package:wedding_witness_app/features/wedding/domain/entities/song.dart';

abstract class SongDataSource {
  Future<List<SongModel>> getSongs();
  Future<String> downloadSong(Song song);
}

class SongDataSourceImpl implements SongDataSource {
  final Dio dio;

  SongDataSourceImpl({required this.dio});

  @override
  Future<List<SongModel>> getSongs() async {
    try {
      final response = await dio.get('songs');

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.data);
        return data.map((json) => SongModel.fromJson(json)).toList();
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
  Future<String> downloadSong(Song song) async {
    try {
      final response = await dio.get(
        'songs/${song.id}/download',
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200) {
        final Directory directory = await getApplicationDocumentsDirectory();
        final String filePath = "${directory.path}/${song.fileName}";

        print('Téléchargement de la chanson : ${song.title} (${song.fileName}) vers $filePath');
        final File file = File(filePath);

        final bool alreadyExist = await file.exists();

        if (alreadyExist) {
          print('Le fichier existe déjà : $filePath');
          return filePath;
        }
        await file.writeAsBytes(response.data);

        return filePath;
      } else {
        print(
          'Erreur lors du téléchargement de la chanson : ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Erreur lors du téléchargement : $e');
    }
    return '';
  }
}
