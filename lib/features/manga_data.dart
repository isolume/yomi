import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:yomi/constants/links.dart';

Future<List<dynamic>> fetchSearch(String query) async {
  final result = await http.read(Uri.parse("$mdApiUrl/manga?title=$query"));
  final data = json.decode(result) as Map<String, dynamic>;
  return data['data'] ?? [];
}

Future<dynamic> fetchManga(String id) async {
  final result = await http.read(Uri.parse("$mdApiUrl/manga/$id"));
  final data = json.decode(result) as Map<String, dynamic>;
  return data['data'] ?? [];
}

// Function to get cover image for manga
Future<Widget> fetchCover(String id) async {
  final result = await http.read(Uri.parse("$mdApiUrl/manga/$id"));
  final data = json.decode(result) as Map<String, dynamic>;
  final List<dynamic> relationships = data['data']['relationships'] ?? [];

  final coverMap = relationships.firstWhere((item) => item['type'] == 'cover_art');
  final coverId = coverMap['id'];
  final coverNameResult = await http.read(Uri.parse("$mdApiUrl/cover/$coverId"));
  final coverNameData = json.decode(coverNameResult) as Map<String, dynamic>;
  final coverName = coverNameData['data']['attributes']['fileName'];
  final cover = "$mdUploadUrl/covers/$id/$coverName";

  return SizedBox(child: Image.network(cover), width: 200, height: 300);
}