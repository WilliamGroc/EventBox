import 'package:flutter/material.dart';
import 'package:wedding_witness_app/features/wedding/device/music_player.dart';
import 'package:wedding_witness_app/features/wedding/domain/entities/song.dart';

class MusicPlayerScreen extends StatefulWidget {
  final Song? song;

  const MusicPlayerScreen({super.key, this.song});

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  final MusicPlayer _musicPlayer = MusicPlayer();
  bool _isPlaying = false;

  @override
  void dispose() {
    _musicPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Player de Musique')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (widget.song != null) {
                  await _musicPlayer.playFromFile(widget.song!);
                  setState(() {
                    _isPlaying = true;
                  });
                }
              },
              child: const Text('Jouer depuis un fichier'),
            ),
            const SizedBox(height: 20),
            IconButton(
              icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
              iconSize: 48,
              onPressed: () async {
                if (_isPlaying) {
                  await _musicPlayer.pause();
                } else {
                  await _musicPlayer.resume();
                }
                setState(() {
                  _isPlaying = !_isPlaying;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _musicPlayer.stop();
                setState(() {
                  _isPlaying = false;
                });
              },
              child: const Text('Arrêter'),
            ),
          ],
        ),
      ),
    );
  }
}
