import 'package:flutter/material.dart';
import 'package:reader_tracker/db/database_helper.dart';
import 'package:reader_tracker/models/book.dart';
import 'package:reader_tracker/utils/book_details_arguments.dart';

class BookDetailsScreen extends StatefulWidget {
  const BookDetailsScreen({super.key});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as BookDetailsArguments;
    final Book book = args.itemBook;
    final bool isFromSavedScreen = args.isFromSavedScreen;
    
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (book.imageLinks.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Image.network(
                  book.imageLinks['thumbnail'] ?? '',
                  fit: BoxFit.cover
                ),
            ),
            Center(
              child: Column(
                children: [
                  Text(
                    book.title, 
                    style: theme.headlineSmall,
                  ),
                  Text(
                    book.authors.join(', '),
                    style: theme.labelLarge,
                  ),
                  Text(
                    'Published: ${book.publishedDate}',
                    style: theme.bodySmall
                  ),
                  Text('Page Count: ${book.pageCount}', style: theme.bodySmall),
                  Text('Language: ${book.language}', style: theme.bodySmall),
                  const SizedBox(height: 7),

                  SizedBox(
                    child: !isFromSavedScreen ? ElevatedButton(
                        onPressed: () async {
                          // save a book to the database
                          try {
                            int savedInt = await DatabaseHelper.instance.insert(book);
                            SnackBar snackBar = SnackBar(content: Text("Book Saved $savedInt"));
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);                      

                          } catch (e) {
                            print("Error: $e");
                          }
                        }, 
                        child: Text('Save')) : ElevatedButton.icon(
                        onPressed: () async {}, 
                        icon: Icon(Icons.favorite),
                        label: Text('Favourite'))
                    
                    
                  ),

                  // Row(
                  //   mainAxisAlignment: !isFromSavedScreen ? MainAxisAlignment.spaceEvenly : MainAxisAlignment.center,
                  //   children: [
                  //     !isFromSavedScreen ? ElevatedButton(
                  //       onPressed: () async {
                  //         // save a book to the database
                  //         try {
                  //           int savedInt = await DatabaseHelper.instance.insert(book);
                  //           SnackBar snackBar = SnackBar(content: Text("Book Saved $savedInt"));
                  //           ScaffoldMessenger.of(context).showSnackBar(snackBar);                      

                  //         } catch (e) {
                  //           print("Error: $e");
                  //         }
                  //       }, 
                  //       child: Text('Save')
                  //     ) : const SizedBox(),
                  //     ElevatedButton.icon(                       
                  //       onPressed: () async {
                          
                  //       }, 
                  //       icon: Icon(Icons.favorite),
                  //       label: Text('Favourite'))
                  //   ],              
                  // ),
                  const SizedBox(height: 12),
                  Text('Description', style: theme.titleMedium),
                  const SizedBox(height: 5),
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.secondary
                      )
                    ),
                    child: Text(book.description),
                  )
                ],
              ),
            )
          ],
          ),
      ),
    );
  }
}