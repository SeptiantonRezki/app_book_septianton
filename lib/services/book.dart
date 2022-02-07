import 'dart:async';
import 'dart:convert';
import 'package:app_book_septianton/models/author.dart';
import 'package:http/http.dart' as http;

import 'package:app_book_septianton/models/book.dart';

// const _url = "http://192.168.137.1/api/v1";
const _url = "http://192.168.56.1:55521/api/v1";
// const _url = "http://208.87.132.73:55521//api/v1";
// const _url = "http://localhost:5021/api/v1";

Future<Book> getBook({required id}) async {
  try {
    Book book;
    var url = Uri.parse("$_url/book/$id");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      book = Book.fromJson(responseData["data"]);
      return book;
    }
  } catch (e) {
    // print(e.toString());
  }
  return Book.initial();
}

Future<List<Book>>? getBooks({limit = 10, skip = 0, search = ""}) async {
  List<Book> books = [];
  try {
    var url = Uri.parse("");
    if (limit == "no-limit") {
      url = Uri.parse("$_url/book?limit=$limit");
    } else {
      url = Uri.parse("$_url/book?limit=$limit&skip=$skip&search=$search");
    }
    var response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      for (var item in responseData["data"]) {
        books.add(Book.fromJson(item));
      }
    }
  } catch (e) {
    // print(e.toString());
  }
  return books;
}

Future<List<Author>> getAuthors() async {
  List<Author> authors = [];
  try {
    var url = Uri.parse("$_url/author");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      for (var item in responseData["data"]) {
        authors.add(Author.fromJson(item));
      }
    }
  } catch (e) {
    // print(e.toString());
  }
  return authors;
}

Future<List<Book>> getBooksAuthor({required String author}) async {
  List<Book> booksAuthor = [];
  try {
    var url = Uri.parse("$_url/author?author=$author");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      for (var item in responseData["data"]) {
        booksAuthor.add(Book.fromJson(item));
      }
    }
  } catch (e) {
    // print(e.toString());
  }
  return booksAuthor;
}

// void main(List<String> args) async {
//   // var books = await getBook();
//   // for (var item in books) {
//   //   print(item.author);
//   // }
//   var authors = await getAuthors();
//   for (var item in authors) {
//     print(item.name);
//   }

  // var book = await getBook(id: 4);
  // print(book.country);
  // print(book);
  // print(book.author);
// }
