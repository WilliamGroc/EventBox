

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wedding_witness_app/features/wedding/presentation/controller/song_controller.dart';
import 'package:wedding_witness_app/features/wedding/presentation/widgets/music.widget.dart';

class SongsScreen extends ConsumerWidget {
  const SongsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songs = ref.watch(songControllerProvider);
    
    return Scaffold(
      body: songs.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Erreur : $error')),
        data: (songs) {
          return Column(
            children: [
              const SizedBox(height: 20),
              const Text('Liste des chansons', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: songs.length,
                  itemBuilder: (context, index) {
                    final song = songs[index];
                    return ListTile(
                      title: Text(song.fileName),
                      onTap: () {
                        // Naviguer vers l'écran de lecture de musique
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MusicPlayerScreen(song: song),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

}