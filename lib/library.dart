import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yomi/main.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    if (appState.manga.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '(´･-･)',
              style: TextStyle(fontSize: 60),
            ),
            Text('No manga found'),
          ],
        ),
      );
    }

    return const Text(
      'whoops',
    );
  }
}