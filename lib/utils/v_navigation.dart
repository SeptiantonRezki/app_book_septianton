import 'package:app_book_septianton/views/book/author/author_book_list.dart';
import 'package:app_book_septianton/views/book/book_page.dart';
import 'package:app_book_septianton/views/book/book_search.dart';
import 'package:flutter/material.dart';
import 'package:app_book_septianton/views/book/book_detail.dart';

class VNavigation {
  static gotoNavigation(context) {
    return Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const BookPage(),
        transitionDuration: Duration.zero,
      ),
    );
  }

  static gotoDetailBook(context, int id) {
    return Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => BookDetail(
          id: id,
        ),
        transitionDuration: Duration.zero,
      ),
    );
  }

  static gotoSearchBook(context) {
    return Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const BookSearch(),
        transitionDuration: Duration.zero,
      ),
    );
  }

  static gotoAuthorBooks(context, String author) {
    return Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => AuthorBookList(author: author),
        transitionDuration: Duration.zero,
      ),
    );
  }
}
