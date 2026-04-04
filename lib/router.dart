import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wedding_witness_app/features/wedding/presentation/screens/chat_screen.dart';
import 'package:wedding_witness_app/features/wedding/presentation/screens/home_screen.dart';
import 'package:wedding_witness_app/features/wedding/presentation/screens/songs_screen.dart';
import 'package:wedding_witness_app/features/wedding/presentation/screens/tasklist_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return Scaffold(
            appBar: AppBar(title: const Text('Wedding Witness')),
            body: child,
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _calculateSelectedIndex(state),
              onTap: (index) => _onItemTapped(index, context),
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Accueil',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.checklist),
                  label: 'Checklist',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.music_note),
                  label: 'Musiques',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat_bubble_outline),
                  label: 'Chat',
                ),
              ],
            ),
          );
        },
        routes: [
          GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
          GoRoute(
            path: '/checklist',
            builder: (context, state) => const ChecklistScreen(),
          ),
          GoRoute(
            path: '/songs',
            builder: (context, state) => const SongsScreen(),
          ),
          GoRoute(
            path: '/chat',
            builder: (context, state) => const ChatScreen(),
          ),
        ],
      ),
    ],
  );
});

int _calculateSelectedIndex(GoRouterState state) {
  switch (state.fullPath) {
    case '/checklist':
      return 1;
    case '/songs':
      return 2;
    case '/chat':
      return 3;
    default:
      return 0;
  }
}

void _onItemTapped(int index, BuildContext context) {
  switch (index) {
    case 0:
      context.go('/');
    case 1:
      context.go('/checklist');
    case 2:
      context.go('/songs');
    case 3:
      context.go('/chat');
  }
}

