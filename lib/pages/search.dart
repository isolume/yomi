import 'package:flutter/material.dart';
import 'package:yomi/widgets/search_bar.dart';
import 'package:yomi/widgets/manga_card.dart';
import 'package:yomi/features/manga_data.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? query;
  Future<List<dynamic>>? searchResults;

  void updateSearch(String query) {
    setState(() {
      searchResults = fetchSearch(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: searchBar(updateSearch),
        ),
        if (searchResults != null)
          FutureBuilder(
            future: searchResults,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Column(
                  children: (snapshot.data ?? []).map((data) =>
                  MangaCard(id: data['id'].toString())).toList(),
                );
              }
            }
          ),
      ],
    );
  }
}