import 'package:app_book_septianton/models/book.dart';
import 'package:app_book_septianton/services/book.dart';
import 'package:app_book_septianton/utils/v_navigation.dart';
import 'package:flutter/material.dart';

class BookItem extends StatefulWidget {
  final String title;
  final int limit;
  final int skip;
  const BookItem(
      {required this.title, required this.limit, required this.skip, Key? key})
      : super(key: key);

  @override
  _BookItemState createState() => _BookItemState();
}

class _BookItemState extends State<BookItem> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Book>>(
      future: getBooks(limit: widget.limit, skip: widget.skip),
      builder: (BuildContext context, AsyncSnapshot<List<Book>> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          List<Book> books = snapshot.data!;
          children = <Widget>[
            Text(widget.title),
            const SizedBox(height: 10),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.8,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: books.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, i) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.width * 0.4,
                            width: MediaQuery.of(context).size.width * 0.3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: NetworkImage(books[i].imageLink),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: Text(
                            books[i].title,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: Text(
                            books[i].author,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            VNavigation.gotoDetailBook(context, books[i].id);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.width * 0.02),
                            child: Text(
                              "Detail Book",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
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
          children = <Widget>[
            Text(widget.title),
            const SizedBox(height: 10),
            const SizedBox(
              height: 200,
              child: Center(
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ];
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        );
      },
    );
  }
}
