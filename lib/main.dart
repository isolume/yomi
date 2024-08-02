import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yomi/library.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        title: 'Yomi',
        theme: ThemeData(
          brightness: Brightness.light,
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green)
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen, brightness: Brightness.dark)
        ),
        themeMode: ThemeMode.dark,
        home: const HomePage(),
      )
    );
  }
}

class AppState extends ChangeNotifier {
  var manga = <String>[];
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = const LibraryPage();
      case 1:
        page = const Placeholder();
      default:
        throw UnimplementedError('No widget for $selectedIndex');
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Container(
            child: page,
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.collections_bookmark_outlined),
                activeIcon: Icon(Icons.collections_bookmark),
                label: 'Library',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.explore_outlined),
                activeIcon: Icon(Icons.explore),
                label: 'Search',
              )
            ],
            currentIndex: selectedIndex,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            onTap: (value) {
              setState(() {
                selectedIndex = value;
              });
            },
          ),
        );
      });
  }
}

