import 'package:app_book_septianton/utils/v_navigation.dart';
import 'package:app_book_septianton/views/book/book_carousel.dart';
import 'package:app_book_septianton/views/book/book_item.dart';
import 'package:flutter/material.dart';

class BookList extends StatefulWidget {
  const BookList({Key? key}) : super(key: key);

  @override
  _BookListState createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
            child: TextField(
              decoration: const InputDecoration(
                suffixIcon: Icon(Icons.search),
              ),
              onTap: () {
                VNavigation.gotoSearchBook(context);
              },
            ),
          ),
          const SizedBox(
            height: 250,
            child: ComplicatedImageDemo(),
          ),
          const SizedBox(height: 10),
          const BookItem(title: "Favourite Books", limit: 10, skip: 0),
          const BookItem(title: "Recomendation Books", limit: 10, skip: 20),
        ],
      ),
    );
  }
}
