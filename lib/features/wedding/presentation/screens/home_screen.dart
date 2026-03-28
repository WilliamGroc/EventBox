import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Bienvenue sur Wedding Witness!'),
            SizedBox(height: 16),
            Text('Votre assistant pour organiser votre mariage.'),
          ],
        ),
      );
  }
}
