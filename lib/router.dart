import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wedding_witness_app/features/wedding/presentation/screens/home_screen.dart';
import 'package:wedding_witness_app/features/wedding/presentation/screens/tasklist_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          // Ce builder définit le layout commun à toutes les sous-routes.
          return Scaffold(
            appBar: AppBar(title: const Text('Wedding Witness App')),
            body: child, // Ici, le contenu de chaque sous-route sera affiché.
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _calculateSelectedIndex(state),
              onTap: (index) => _onItemTapped(index, context),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Accueil',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.checklist),
                  label: 'Checklist',
                ),
              ],
            ),
          );
        },
        routes: [
          // Sous-routes qui utiliseront le layout défini ci-dessus.
          GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
          GoRoute(
            path: '/checklist',
            builder: (context, state) => const ChecklistScreen(),
          ),
        ],
      ),
    ],
  );
});

// Fonction pour déterminer l'index sélectionné dans la BottomNavigationBar.
int _calculateSelectedIndex(GoRouterState state) {
  if (state.fullPath == '/checklist') return 1;
  return 0; // Par défaut, l'index 0 correspond à la route '/'.
}

// Fonction pour gérer les clics sur la BottomNavigationBar.
void _onItemTapped(int index, BuildContext context) {
  switch (index) {
    case 0:
      context.go('/');
      break;
    case 1:
      context.go('/checklist');
      break;
  }
}
