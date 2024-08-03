import 'package:flutter/material.dart';

Widget searchBar(Function(String) onSubmitted) {
  return TextField(
    decoration: InputDecoration(
      hintText: 'Search',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide.none
      ),
      filled: true,
      fillColor: Colors.grey[900],
      contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    ),
    onSubmitted: onSubmitted,
  );
}