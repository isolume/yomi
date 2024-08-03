import 'package:flutter/material.dart';
import 'package:yomi/features/manga_data.dart';

Future<Widget> mangaCardFuture(String id) async {
  final mangaData = await fetchManga(id);
  final cover = await fetchCover(id);

  return Card(
    child: Column(
      children: [
        cover,
        Text(mangaData['attributes']['title']['en'].toString()),
      ],
    ),
  );
}

Widget mangaCard(Future<Widget> mangaCard) {
  return FutureBuilder(
    future: mangaCard,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator();
      } else if (snapshot.hasError) {
        return Card(
          child: Column(
            children: [
              const Icon(Icons.error),
              Text('Error: ${snapshot.error}'),
            ],
          ),
        );
      } else {
        return snapshot.data!;
      }
    },
  );
}