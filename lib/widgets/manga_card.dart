import 'package:flutter/material.dart';
import 'package:yomi/features/manga_data.dart';

class MangaCard extends StatelessWidget {
  final String id;

  const MangaCard({super.key, required this.id});

  Future<Map<String, dynamic>> fetchMangaData(String id) async {
    final mangaData = await fetchManga(id);
    final cover = await fetchCover(id);
    return {'mangaData': mangaData, 'cover': cover};
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchMangaData(id),
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
          final mangaData = snapshot.data!['mangaData'];
          final cover = snapshot.data!['cover'];
          return Card(
            child: Column(
              children: [
                cover,
                Text(mangaData['attributes']['title']['en'].toString()),
              ],
            ),
          );
        }
      },
    );
  }
}