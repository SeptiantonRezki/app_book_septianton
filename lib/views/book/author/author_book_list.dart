import 'package:app_book_septianton/models/book.dart';
import 'package:app_book_septianton/services/book.dart';
import 'package:app_book_septianton/utils/v_navigation.dart';
import 'package:flutter/material.dart';

class AuthorBookList extends StatefulWidget {
  final String author;
  const AuthorBookList({required this.author, Key? key}) : super(key: key);

  @override
  _AuthorBookListState createState() => _AuthorBookListState();
}

class _AuthorBookListState extends State<AuthorBookList> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        VNavigation.gotoNavigation(context);
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: FutureBuilder<List<Book>>(
              future: getBooksAuthor(author: widget.author),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Book>> snapshot) {
                List<Widget> children;
                if (snapshot.hasData) {
                  var booksAuthor = snapshot.data!;
                  children = [
                    Text(widget.author),
                    const SizedBox(height: 10),
                    ...booksAuthor.map((e) {
                      return GestureDetector(
                        onTap: () {
                          VNavigation.gotoDetailBook(context, e.id);
                        },
                        child: ListTile(
                          title: Text(e.title),
                          subtitle: Text(e.year),
                        ),
                      );
                    }).toList()
                  ];
                } else if (snapshot.hasError) {
                  children = <Widget>[
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('Error: ${snapshot.error}'),
                    )
                  ];
                } else {
                  children = const <Widget>[
                    SizedBox(
                      child: CircularProgressIndicator(),
                      width: 60,
                      height: 60,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Awaiting result...'),
                    )
                  ];
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: children,
                  ),
                );
              }),
        ),
      ),
    );
  }
}
