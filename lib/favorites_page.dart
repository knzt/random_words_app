import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'my_app_state.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.favorites.isEmpty) {
      return Center(
        child: Text('No favorites yet.',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Text(
              'You have ${appState.favorites.length} favorites:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
        for (var pair in appState.favorites)
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 40),
            leading: Icon(
              Icons.delete,
              color: Theme.of(context).colorScheme.tertiary,
              size: 28,
            ),
            onTap: () {
              appState.toggleFavorite();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  content: Row(
                    children: [
                      Icon(
                        Icons.delete,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Removed ${pair.asLowerCase} from favorites.',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      appState.undoRemoveFavorite(pair);
                    },
                    textColor: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              );
            },
            title: Text(
              pair.asLowerCase,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
      ],
    );
  }
}
