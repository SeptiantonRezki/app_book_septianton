import 'package:app_book_septianton/models/bookmark.dart';
import 'package:app_book_septianton/services/sqlite.dart';
import 'package:flutter/material.dart';

class BookBookmart extends StatefulWidget {
  const BookBookmart({Key? key}) : super(key: key);

  @override
  _BookBookmartState createState() => _BookBookmartState();
}

class _BookBookmartState extends State<BookBookmart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: FutureBuilder<List<Bookmark>>(
            future: getBookmarks(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Bookmark>> snapshot) {
              Widget child;
              if (snapshot.hasData) {
                List<Bookmark> bookmarks = snapshot.data!;
                child = ListView.builder(
                    itemCount: bookmarks.length,
                    itemBuilder: (BuildContext context, i) {
                      return ListTile(
                        title: Text(bookmarks[i].title),
                        subtitle: Text(bookmarks[i].description),
                        trailing: const Icon(Icons.remove),
                      );
                    });
              } else if (snapshot.hasError) {
                child = Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text('Error: ${snapshot.error}'),
                      )
                    ],
                  ),
                );
              } else {
                child = Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator(),
                      ),
                      SizedBox(height: 10),
                      Text("Loading...")
                    ],
                  ),
                );
              }
              return child;
            },
          ),
        ),
      ),
    );
  }
}
