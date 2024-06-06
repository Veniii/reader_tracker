import 'package:flutter/material.dart';
import 'package:reader_tracker/db/database_helper.dart';
import 'package:reader_tracker/models/book.dart';
import 'package:reader_tracker/utils/book_details_arguments.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {

  // final Book book = book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Saved'),
      ),
      body: FutureBuilder<List<Book>>(
        future: DatabaseHelper.instance.readAllBooks(), 
        builder: (context, snapshot) => snapshot.hasData 
        ? ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            Book book = snapshot.data![index];
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/details',
                arguments: BookDetailsArguments(itemBook: book, isFromSavedScreen: true)               
                );
              },
              child: Card(
                child: ListTile(
                  title: Text(book.title),
                  trailing: IconButton(icon: const Icon(Icons.delete), onPressed: () {
                    print("delete ${book.id}");   
                    DatabaseHelper.instance.deleteBook(book.id);
                    setState(() {                   
                    });                          
                  },),
                  leading: Image.network(
                    book.imageLinks['thumbnail'] ?? '', 
                    fit: BoxFit.cover
                  ),
                  subtitle: Column(
                    children: [
                      Text(book.authors.join(', ')),
                      ElevatedButton.icon(
                        onPressed: () async {
                        // toggle the favorite flag
                        await DatabaseHelper.instance
                        .toggleFavoriteStatus(book.id, !book.isFavorite)
                        .then((value) => print("Item Favoured!!! $value"));
                        }, 
                        icon: const Icon(Icons.favorite), label: const Text("Add to favorites"))
                    ],
                  ),
              
                  
                ),
              ),
            );

        }) 
        : const Center(child: CircularProgressIndicator())) 
    );
  }
}