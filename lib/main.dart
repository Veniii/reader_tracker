import 'package:flutter/material.dart';
import 'package:reader_tracker/models/book.dart';
import 'package:reader_tracker/network/network.dart';
import 'package:reader_tracker/screens/books_details.dart';
import 'package:reader_tracker/screens/favourites_screen.dart';
import 'package:reader_tracker/screens/home_screen.dart';
import 'package:reader_tracker/screens/saved_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/home': (context) => const HomeScreen(),
        '/saved': (context) => const SavedScreen(),
        '/favourites': (context) => const FavouritesScreen(),
        '/details': (context) => const BookDetailsScreen(),
      },
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  // @override
  // void initState() {
  //   _searchBooks('Android');
  //   super.initState();
  // }

  final List<Widget> _screens = [
    const HomeScreen(),
    const SavedScreen(),
    const FavouritesScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('A.Reader'),
        ),
      body: _screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          items: const <BottomNavigationBarItem> [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.save), label: 'Saved'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favourite')
            ],
            selectedItemColor: Theme.of(context).colorScheme.onPrimary,
            unselectedItemColor: Theme.of(context).colorScheme.onSurfaceVariant,
            onTap: (value) {
              setState(() {
                _currentIndex = value;
              });
            }
          ),
    );
  }
}