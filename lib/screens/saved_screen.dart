import 'package:flutter/material.dart';
import 'package:reader_tracker/db/database_helper.dart';
import 'package:reader_tracker/models/book.dart';

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
        title: Text('Saved'),
      ),
      body: FutureBuilder<List<Book>>(
        future: DatabaseHelper.instance.readAllBooks(), 
        builder: (context, snapshot) => snapshot.hasData 
        ? ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            Book book = snapshot.data![index];
            return ListTile(
              title: Text(book.title),
            );

        }) 
        : const Center(child: CircularProgressIndicator())) 
    );
  }
}