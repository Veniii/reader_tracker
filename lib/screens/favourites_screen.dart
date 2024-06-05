import 'package:flutter/material.dart';
import 'package:reader_tracker/db/database_helper.dart';
import 'package:reader_tracker/models/book.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: FutureBuilder(future: DatabaseHelper.instance.getFavourites(), builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          List<Book> favBooks = snapshot.data!;

          return ListView.builder(
            itemCount: favBooks.length, 
            itemBuilder: (context, index) {
              Book book = favBooks[index];
              return Card(
                child: ListTile(
                  leading: Image.network(book.imageLinks['thumbnail'] ?? '', fit: BoxFit.cover),
                  title: Text(book.authors.join(', ')),
                  trailing: const Icon(Icons.favorite, color: Colors.red)
                ) 
              );
          });
        } else {
          return const Center(
            child: Text('No favorite books found'),
          );
        }
        
      })),
    );
  }
}